json.user do
  json.extract! @user, :id, :name
end

json.feeds do |json|
  json.array!(@microposts) do |micropost|
    json.extract! micropost, :id, :content, :user_id
  end
end
