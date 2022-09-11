class Validators::Locations
  CreateSchema = Dry::Schema.Params do
    required(:name).filled(:string)
  end
end
