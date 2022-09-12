class Games::GetAll::ValidatePresence
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    games = Game.all

    if games.present?
      Success input.merge!({ games: games })
    else
      name = I18n.t("activerecord.errors.models.game.attributes.year_game.empty_game")
      error = I18n.t('error_messages.unprocessable_entity.invalid.message', name: name)
      response = {
        error: error,
        name: name,
        url_errors: 'error_messages.unprocessable_entity.invalid'
      }

      Failure(response)
    end
  end
end
