json.data @locations do |location|
  json.partial! 'v1/locations/location', location: location
end
