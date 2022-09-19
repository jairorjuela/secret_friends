require 'test_helper'

module V1
  class WorkersControllerTest < ActionDispatch::IntegrationTest
    include ParsedResponse
    include WorkerAsserts
    include WorkersSupport
  
    test 'Index workers' do
      get_workers_index
  
      assert_response :ok
      assert_equal Worker.all.size, response_data.size, 'Index workers'
    end
  
    test 'Create worker' do
      params = worker_params
  
      post_workers_create(params)
  
      assert_response :ok
      worker_response_asserts
    end
  
    test 'Invalid create worker' do
      params = invalid_worker_params
  
      post_workers_create(params)
  
      assert_response :unprocessable_entity
      assert_equal '0101', response_error_code, 'Error code with invalid request'
    end
  
    def get_workers_index
      get v1_workers_path
    end
  
    def post_workers_create(params = {})
      post v1_workers_path params: params
    end
  end
end
