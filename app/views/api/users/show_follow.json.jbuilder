json.user do
  json.id @user.id
  json.name @user.name
  json.admin @user.admin
end

json.set! @title do |json|
  json.array!(@users) do |user|
    json.extract! user, :id, :name
    json.img gravatar_url(user, size: 50)
  end
end
