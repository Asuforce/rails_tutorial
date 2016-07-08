json.users do |json|
  json.array!(@users) do |user|
    json.extract! user, :id, :name, :email
    json.url user_path(user, format: :json)
  end
end
