json.user do |json|
  json.name @user.name
  json.email @user.email
  json.password @user.password
  json.password_confirmation @user.password_confirmation
end
