json.array!(@students) do |student|
  json.extract! student, :id, :name, :address_id, :school_id
  json.url student_url(student, format: :json)
end
