json.user do
  json.extract! @user, :id, :name, :admin
end

json.set! @title.downcase do
  json.array!(@users) do |user|
    json.extract! user, :id, :name
    json.img gravatar_url(user, size: 50)
  end
end
