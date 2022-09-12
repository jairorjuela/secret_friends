require 'dry/transaction/operation'

class Games::Create::ValidateYear
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    year_exist = Game.where(year_game: input[:year_game]).last.present?

    if year_exist
      name = I18n.t("activerecord.errors.models.game.attributes.year_game.year_taken")
      error = I18n.t('error_messages.unprocessable_entity.invalid.message', name: name)
      response = {
        error: error,
        name: name,
        url_errors: 'error_messages.unprocessable_entity.invalid'
      }

      Failure(response)
    else
      Success input
    end
  end
end
