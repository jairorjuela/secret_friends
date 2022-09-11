class Validators::Games
  CreateSchema = Dry::Schema.Params do
    required(:year_game).filled(:string, format?: /^(202\d|2030)$/)
  end
end
