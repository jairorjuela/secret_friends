module V1
  class LocationsController < ApplicationController
    include ExceptionsResponse
    def index
    end

    def create
      create_params = location_params
      create_worker = Locations::Create::Execute::RUN_ALL.new.call(create_params)
      render_actions(create_worker, :create)
    end

    private

    def location_params
      params.require(:location)
            .permit(:name)
            .to_h.symbolize_keys
    end

    def render_actions(response, action)
      if response.success?
        @locations = response.success
        render action, status: :ok
      else
        services_errors(response.failure, :location)
      end
    end
  end
end
