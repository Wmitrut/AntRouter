json.array!(@addresses) do |address|
  json.extract! address, :id, :latitude, :longitude
  json.url address_url(address, format: :json)
end
