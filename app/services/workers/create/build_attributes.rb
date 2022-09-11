class Workers::Create::BuildAttributes
  include Dry::Transaction::Operation

  def call(input)
    worker_attrs = {
      name: input[:name],
      location: input[:location]
    }

    input.merge!(worker_attrs: worker_attrs)
  end
end
