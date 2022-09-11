module Locations::GetAll::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    map :build_response, with: Locations::GetAll::BuildResponse.new
  end.execute_steps
end
