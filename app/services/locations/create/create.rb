class Locations::Create::Create
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    location = Location.new({ name: input[:name] })

    if location.save
      Success input.merge!(location: location)
    else
      Failure create_or_update_errors(location.errors)
    end
  end
end
