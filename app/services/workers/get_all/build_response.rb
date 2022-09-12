require 'dry/transaction/operation'

class Workers::GetAll::BuildResponse
  include Dry::Transaction::Operation

  def call(input)
    Worker.all.each_with_object([]) do |worker, array|
      array << {
        name: worker.name,
        id: worker.id,
        location: worker.location.name,
        year_game: worker.year_game
      }
    end
  end
end
