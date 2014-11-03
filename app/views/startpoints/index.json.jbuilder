json.array!(@startpoints) do |startpoint|
  json.extract! startpoint, :id, :address_id
  json.url startpoint_url(startpoint, format: :json)
end
