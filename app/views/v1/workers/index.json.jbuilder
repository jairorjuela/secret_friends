json.data @workers do |worker|
  json.partial! 'v1/workers/worker', worker: worker
end
