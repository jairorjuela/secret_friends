module Workers::Create::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    step :validation, with: ::Common::Operations::Validator.call(:create, :workers)
    step :find_location, with: Workers::FindObjects.new(:location)
    map :build_attributes, with: Workers::Create::BuildAttributes.new
    step :create, with: Workers::Create::Create.new
    map :build_response, with: Workers::Create::BuildResponse.new
  end.execute_steps
end
