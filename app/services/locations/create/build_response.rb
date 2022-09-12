require 'dry/transaction/operation'

class Locations::Create::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    {
      id: input[:location].id,
      name: input[:location].name
    }
  end
end
