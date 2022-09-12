require 'dry/transaction/operation'

class Workers::Create::Create
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    worker = Worker.new(input[:worker_attrs])

    if worker.save
      Success input.merge!(worker: worker)
    else
      Failure create_or_update_errors(worker.errors)
    end
  end
end
