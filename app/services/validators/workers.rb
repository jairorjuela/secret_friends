class Validators::Workers
  CreateSchema = Dry::Schema.Params do
    required(:name).filled(:string)
    required(:location_id).filled(:string)
  end
end
