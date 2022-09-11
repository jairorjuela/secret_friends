# frozen_string_literal: true

module Common::Operations::DryErrors
  def validate_errors(errors)
    translate_errors(errors, :validate)
  end

  def create_or_update_errors(errors)
    translate_errors(errors, :create)
  end

  private

  def translate_errors(errors, origin)
    errors.each_with_object([]) do |error, array|
      array << build_error(error, origin)
    end
  end

  def build_error(error, origin)
    error_message = build_error_message(error, origin)
    key_error_message = build_key_error(error, origin)
    url_error_path = build_url_error(error, origin)

    { error: error_message,
      key_error: key_error_message,
      url_errors: url_error_path }
  end

  def build_error_message(error, origin)
    origin.eql?(:create) ? error.message : "#{error.path} #{error.text}"
  end

  def build_key_error(error, origin)
    origin.eql?(:create) ? error.attribute : error.path.first
  end

  def build_url_error(error, origin)
    if origin.eql?(:create)
      'error_messages.unprocessable_entity.invalid'
    else
      camel_case_error = error.text.gsub(' ', '_')
      type_error = parse_errors(camel_case_error)
      "error_messages.#{type_error}"
    end
  end

  def parse_errors(error)
    options = {
      'is_missing' => -> { 'not_found.dry_validation' }
    }

    options.default = -> { 'unprocessable_entity.invalid' }
    options[error].call
  end
end
