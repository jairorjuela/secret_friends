class Games::Create::FilterWorkers
  include Dry::Transaction::Operation
  include Common::Operations::DryErrors

  def call(input)
    get_workers = get_worker_to_play

    if get_workers.klass.eql?(Worker)
      response = final_response(get_workers)

      Success input.merge!(response)
    else
      name = I18n.t("activerecord.errors.models.worker.attributes.invalid_quantity")
      error = I18n.t('error_messages.unprocessable_entity.invalid.message', name: name)
      response = {
        error: error,
        name: name,
        url_errors: 'error_messages.unprocessable_entity.invalid'
      }

      Failure(response)
    end
  end

  private

  def get_worker_to_play
    total_workers = Worker.count

    return if total_workers <= 1

    even_number = (total_workers % 2).zero?

    return Worker.all if even_number

    $worker_without_play = Worker.order('RANDOM()').first

    Worker.where.not(id: $worker_without_play.id)
  end

  def final_response(workers)
    if $worker_without_play.present?
      {
        workers: workers,
        worker_without_play: par_data_worker
      }
    else
      { workers: workers }
    end
  end

  def par_data_worker
    {
      id: $worker_without_play.id,
      name: $worker_without_play.name,
      location: $worker_without_play.location.name,
    }
  end
end
