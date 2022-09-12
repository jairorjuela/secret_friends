require 'dry/transaction/operation'

class Games::GetAll::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    response = {}
    response[:games_for_year] = games_for_year(input[:games_data], input[:workers_without_games_data])
    response
  end

  private

  def games_for_year(all_data, workers_without_games_data)
    all_data[:year_games].each_with_object([]) do |year, array|
      hash = {}
      hash["games_#{year}"] = build_games_response(all_data[:games], year)
      not_play = workers_without_games_data.select { |worker| worker[:not_play] == year }
      hash[:not_play] = not_play

      array << hash
    end
  end

  def build_games_response(games, year)
    all_games = games.select { |game| game.year_game == year }
    couple_numbers = all_games.map(&:couple_number).uniq
    workers = Worker.all
    build = Games::Create::BuildResponse.new.call({ games: all_games, couple_numbers: couple_numbers, workers: workers })
    build[:year_game] = year
    build
  end
end
