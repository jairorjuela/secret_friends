json.data do
  json.array! @games[:games_for_year] do |games|
    games.each do |game|
      json.not_play game[-1] if game[0] == :not_play
      next if game[0] == :not_play

      game[-1].each do |game|
        json.year_game game[-1] if game[0] == :year_game
        next if game[0] == :year_game

        json.partial! 'v1/games/game', game: game
      end
    end
  end
end

