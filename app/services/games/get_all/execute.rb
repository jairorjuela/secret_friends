module Games::GetAll::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    step :validate_presence, with: Games::GetAll::ValidatePresence.new
    map :build_attributes, with: Games::GetAll::BuildAttributes.new
    map :build_response, with: Games::GetAll::BuildResponse.new
  end.execute_steps
end
