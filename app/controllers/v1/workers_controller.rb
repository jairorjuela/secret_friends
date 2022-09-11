module V1
  class WorkersController < ApplicationController
    def index
      filters = filters_params

      if filters[:filter].eql?('affiliations')
        affiliations_filter_variables(filters)
      else
        @workers_list = @company.workers_information_list(filters)
        @filters = filters_response(:company_workers_sql, filters)
      end

      render :index, status: :ok
    end

    def create
      create_worker_process
      worker_response(:create, :created)
    end

    private

    def worker_params
      params.require(:worker).permit(
        :account_number, :account_type,
        :active, :address, :birthday, :document_type, :id_number,
        :last_name, :name, :payment_method, :phone, { rest_days: [] },
        :area_id, :bank_id, :cost_center_id, :location_id,
        :position_id
      )
    end

    def enjoyed_days_param
      params.require(:worker).permit(:enjoyed_days_since_hired)
            .dig(:enjoyed_days_since_hired)
    end

    def accumulated_holidays_param
      params.require(:worker).permit(:accumulated_holidays)
            .dig(:accumulated_holidays)
    end

    def user_params
      params.require(:worker).permit(:email, :active_user)
    end

    def verify_exceeds_yearly_plan
      if @company.exceeds_yearly_plan?(action_name)
        exceeds_plan_response('exceeds_yearly_plan', validation: @company.max_payrolls_paid)
      elsif action_name == 'create' && !@company.additional_workers_subscription_info[:add_workers]
        exceeds_plan_response('exceeds_paid_plan', validation: @company.max_payrolls_paid)
      end
    end

    def verify_valid_contract_to_activate
      current_contract = @worker.current_contract

      return if current_contract.blank? ||
                worker_params['active'].to_s.downcase != 'true' ||
                current_contract.in_current_period?

      unprocessable_response('contract_out_of_current_period')
    end

    def verify_demo_worker_data_to_update
      return unless !Rails.env.stage? &&
                    @worker.demo_flag &&
                    %w[name last_name id_number].any? { |key| worker_params.key?(key) }

      unprocessable_response('invalid_demo_worker_update')
    end

    def affiliations_filter_variables(filters)
      @affiliations_list = true
      @affiliations_workers_list = @company.workers_with_affiliations(filters)
      @filters = simple_filters_response(@affiliations_workers_list.size, filters)
    end
  end
end
