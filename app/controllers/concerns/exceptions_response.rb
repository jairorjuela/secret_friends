module ExceptionsResponse
  extend ActiveSupport::Concern

  def base_response(message, status = :ok)
    message = I18n.t(message)
    render json: { message: message },
           status: status
  end

  def services_errors(errors, object)
    errors = services_errors_response_hash(errors, object)
    render json: { error: errors }, status: :unprocessable_entity
  end

  private

  def invalid_errors_response(messages)
    error_array = []
    messages.each do |attrs|
      error_array << error_data(attrs)
    end
    render json: { error: error_array },
           status: :unprocessable_entity
  end

  def error_data(attrs)
    { message: attrs[:message],
      code: attrs[:code],
      object: attrs[:object],
      index: @index || 0 }
  end

  def services_errors_response_hash(errors, object)
    if errors.is_a?(Array)
      array_service_error_response(errors, object)
    else
      service_error_response(errors, object)
    end
  end

  private

  def array_service_error_response(errors, object)
    errors.map do |error|
      return service_error_response(error, object) if error[:key_error].nil?

      name = I18n.t("activerecord.attributes.#{object}.#{error[:key_error]}")
      error.delete(:key_error)
      services_error_hash(error, name, object)
    end
  end

  def service_error_response(error, object)
    name = error[:name]
    error.delete(:name)
    services_error_hash(error, name, object)
  end

  def services_error_hash(error, name, object)
    error[:message] = I18n.t("#{error[:url_errors]}.message", name: name)
    error[:code] = I18n.t("#{error[:url_errors]}.code")
    error[:object] = I18n.t("#{error[:url_errors]}.object", entity: object)
    error[:index] = @index || 0
    error.delete(:error)
    error.delete(:url_errors)
    error
  end
end
