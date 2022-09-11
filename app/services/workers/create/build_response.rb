class Workers::Create::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    {
      id: input[:worker].id,
      name: input[:worker].name,
      location: input[:location].name,
      year_game: input[:worker].year_game
    }
  end
end
