module Workers::GetAll::Execute
  _, RUN_ALL = Common::TxMasterBuilder.new do
    map :build_response, with: Workers::GetAll::BuildResponse.new
  end.execute_steps
end
