# frozen_string_literal: true

module Common
  Dependencies = lambda do |action_type, object_type|
    ops = Common::Operations
    {
      validate_input: -> { ops::Validate.new(validator: Validators::Dependencies[action_type][object_type]) }
    }
  end
end
