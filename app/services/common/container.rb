# frozen_string_literal: true

module Common
  class Container
    extend Dry::Container::Mixin

    register("validator")    { ->(input) { Dry::Monads::Result::Success.new(input) } }

    Import = Dry::AutoInject self
  end
end
