# frozen_string_literal: true

module Common::Operations
  Validator = lambda do |action_type, object_type|
    Common::Operations::Validate.new(validator: ::Validators::Dependencies.new.actions[action_type][object_type])
  end
end
