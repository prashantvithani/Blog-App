module ApplicationHelper
	def gravatar_for(user, model = "header", options = { size: 50 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		if(model == "comment")
			image_tag(gravatar_url, alt: user.full_name, class: "media-object img-circle")
		elsif(model == "home")
			image_tag(gravatar_url, alt: user.full_name, class: "media-object img-rounded")
		elsif(model == "profile")
			image_tag(gravatar_url, alt: user.full_name, class: "social-avatar img-rounded")
		else
			image_tag(gravatar_url, alt: user.full_name, class: "avatar img-circle")
		end
	end
end
