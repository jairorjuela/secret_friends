module WorkerAsserts
  def worker_response_asserts
    worker = Worker.find(response_data['id'])
    assert_equal create_worker_valid_keys, response_data.keys, 'Create worker response'
    assert_equal worker.id, response_data['id']
    assert_equal worker.name, response_data['name']
    assert_equal worker.location.name, response_data['location']
    assert_equal worker.created_at.year.to_s, response_data['year_in_work']
  end
end
