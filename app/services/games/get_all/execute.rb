module Games::GetAll::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    map :build_attributes, with: Games::GetAll::BuildAttributes.new
    map :build_response, with: Games::GetAll::BuildResponse.new
  end.execute_steps
end
