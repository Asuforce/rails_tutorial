json.array!(@users) do |user|
  json.extract! user, :id, :name, :emai
  json.url user_url(user, format: :json)
end
