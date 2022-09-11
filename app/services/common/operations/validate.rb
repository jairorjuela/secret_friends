# frozen_string_literal: true

require 'dry/transaction/operation'

class Common::Operations::Validate
  include Dry::Transaction::Operation
  include Common::Container::Import["validator"]
  include Common::Operations::DryErrors

  def call(input)
    result = validator.call(input.to_h)

    if result.success?
      Success input.deep_symbolize_keys
    else
      Failure validate_errors(result.errors)
    end
  end
end
