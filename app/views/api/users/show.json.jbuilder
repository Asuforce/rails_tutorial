json.feeds do |json|
  json.array!(@microposts) do |micropost|
    json.user_id @user.id
    json.name @user.name
    json.extract! micropost, :id, :content, :created_at
  end
end
