module Games::Create::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    step :validation, with: ::Common::Operations::Validator.call(:create, :games)
    step :validate_year, with: Games::Create::ValidateYear.new
    step :filter_workers, with: Games::Create::FilterWorkers.new
    step :create, with: Games::Create::Create.new
    map :build_response, with: Games::Create::BuildResponse.new
  end.execute_steps
end
