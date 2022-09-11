class Games::GetAll::BuildAttributes
  include Dry::Transaction::Operation

  def call(input)
    games_data = games_all_data
    workers_without_games = workers_without_games_data(games_data[:year_games])

    ({ games_data: games_data, workers_without_games_data: workers_without_games })
  end

  private

  def games_all_data
    games = []
    year_games = []

    Game.all.each do |game|
      games << game
      year_games << game.year_game
    end

    { games: games, year_games: year_games.uniq }
  end

  def workers_without_games_data(year_games)
    year_games.each_with_object([]) do |year, array|
      Worker.all.each do |worker|
        played = worker.games.map(&:year_game).include?(year)
        data = { worker: worker.name, not_play: year } unless played

        array << data
      end
    end.compact
  end
end
