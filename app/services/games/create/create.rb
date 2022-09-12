require 'dry/transaction/operation'

class Games::Create::Create
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    $couple_numbers = []
    games = create_games(input[:workers], input[:year_game])

    if games.is_a?(Array)
      Success input.merge!({ games: games, couple_numbers: $couple_numbers.uniq })
    else
      Failure create_or_update_errors(games.errors)
    end
  end

  private

  def create_games(workers, year_game)
    limit = workers.size
    response = []
    generate_games(workers, limit, year_game, response)
  end

  def generate_games(workers, limit, year_game, response)
    return response if limit.zero?

    workers.shuffle.each do |worker|
      game = Game.new
      game.worker = worker
      game.year_game = year_game
      game.save

      if game.errors.present?
        next
      else
        $couple_numbers << game.couple_number
        response << game
        limit -= 1
      end
    end

    generate_games(workers, limit, year_game, response)
  end
end
