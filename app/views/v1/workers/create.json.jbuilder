json.data do |worker|
  json.partial! 'v1/workers/worker', worker: @workers
end
