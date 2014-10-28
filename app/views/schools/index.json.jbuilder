json.array!(@schools) do |school|
  json.extract! school, :id, :name, :address_id, :arrival
  json.url school_url(school, format: :json)
end
