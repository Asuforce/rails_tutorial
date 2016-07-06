module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    image_tag(gravatar_url(user, options), alt: user.name, class: "gravatar")
  end

  def gravatar_url(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end
