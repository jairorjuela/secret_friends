require 'dry/transaction/operation'

class Workers::FindObjects
  include Dry::Transaction::Operation

  def initialize(type)
    @type = type
  end

  def call(input)
    object_to_find = @type.to_s.camelize.constantize
    object_id = input["#{@type}_id".to_sym]
    object = object_to_find.find_by(id: object_id)

    if object.present?
      Success input.merge!("#{@type}": object)
    else
      name = I18n.t("activerecord.models.#{@type}")
      error = I18n.t('error_messages.not_found.entity.message', name: name)
      response = {
        error: error,
        name: name,
        url_errors: 'error_messages.not_found.entity'
      }

      Failure(response)
    end
  end
end
