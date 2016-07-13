json.user do
  json.id @user.id
  json.name @user.name
end

json.feeds do |json|
  json.array!(@microposts) do |micropost|
    json.extract! micropost, :id, :content, :user_id
  end
end
