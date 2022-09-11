module Locations::Create::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    step :validation, with: ::Common::Operations::Validator.call(:create, :locations)
    step :create, with: Locations::Create::Create.new
    map :build_response, with: Locations::Create::BuildResponse.new
  end.execute_steps
end
