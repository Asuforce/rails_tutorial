json.users do |json|
  json.array!(@users) do |user|
    json.extract! user, :id, :name, :email
  end
end
