module V1
  class WorkersController < ApplicationController
    include ExceptionsResponse

    def index
    end

    def create
      create_params = worker_params
      create_worker = Workers::Create::Execute::RUN_ALL.new.call(create_params)
      render_actions(create_worker, :create)
    end

    private

    def worker_params
      params.require(:worker)
            .permit(:name, :location_id)
            .to_h.symbolize_keys
    end

    def render_actions(response, action)
      if response.success?
        @workers = response.success
        render action, status: :ok
      else
        services_errors(response.failure, :worker)
      end
    end
  end
end
