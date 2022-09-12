require 'dry/transaction/operation'

class Games::Create::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    worker_without_play = input.try(:[], :worker_without_play)
    games, couple_numbers, workers = input.values_at(:games, :couple_numbers, :workers)
    games = build_games_response(games, couple_numbers, workers)
    complement_response = get_year_and_worker(input[:year_game], worker_without_play)

    { games: games }.merge!(complement_response)
  end

  private

  def build_games_response(games, couples, workers)
    couples.each_with_object([]) do |couple, array|
      all_games = games.select { |game| game[:couple_number] == couple }
      parse_response = parse_game_response(all_games, couple, workers)
      next if parse_response.nil?

      array << parse_response
    end
  end

  def get_year_and_worker(year_game, worker_without_play)
    if worker_without_play.present?
      {
        worker_without_play: worker_without_play,
        year_game: year_game
      }
    else
      {
        year_game: year_game
      }
    end
  end

  def parse_game_response(games, number, workers)
    return if games.size < 2

    first_worker = workers.find(games[0].worker_id)
    second_worker = workers.find(games[1].worker_id)

    {
      "couple_#{number}": {
        first_player_name: first_worker.name,
        first_player_id: first_worker.id,
        second_player_name: second_worker.name,
        second_player_id: second_worker.id,
      }
    }
  end
end
