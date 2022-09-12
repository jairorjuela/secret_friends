module V1
  class GamesController < ApplicationController
    include ExceptionsResponse

    def index
      all_games = Games::GetAll::Execute::RUN_ALL.new.call()
      render_actions(all_games, :index)
    end

    def create
      create_params = games_params
      create_game = Games::Create::Execute::RUN_ALL.new.call(create_params)
      render_actions(create_game, :create)
    end

    private

    def games_params
      params.require(:game)
            .permit(:year_game)
            .to_h.symbolize_keys
    end

    def render_actions(response, action)
      if response.success?
        @games = response.success
        render action, status: :ok
      else
        services_errors(response.failure, :worker)
      end
    end
  end
end
