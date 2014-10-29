json.array!(@routes) do |route|
  json.extract! route, :id, :address_id
  json.url route_url(route, format: :json)
end
