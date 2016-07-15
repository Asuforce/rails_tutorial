json.user do
  json.extract! @user, :id, :name, :email
end

json.token @user.create_jwt
