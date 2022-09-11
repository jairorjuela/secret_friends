module Validators
  class Dependencies
    def actions
      {
        create: {
          games: Validators::Games::CreateSchema,
          locations: Validators::Locations::CreateSchema,
          workers: Validators::Workers::CreateSchema
        }
      }
    end
  end
end
