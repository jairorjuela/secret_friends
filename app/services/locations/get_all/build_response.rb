require 'dry/transaction/operation'

class Locations::GetAll::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    Location.all.each_with_object([]) do |location, array|
      array << {
        name: location.name,
        id: location.id
      }
    end
  end
end
