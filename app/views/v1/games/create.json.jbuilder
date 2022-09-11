json.data do
  json.year_game @games[:year_game]
  json.worker_without_play @games[:worker_without_play] if @games[:worker_without_play].present?

  json.all_games @games[:games] do |game|
    json.partial! 'v1/games/game', game: game
  end
end
