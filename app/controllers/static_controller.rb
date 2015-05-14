class StaticController < ApplicationController
	def index
		@posts = Post.order("created_at DESC").all.paginate(page: params[:page], per_page: 10)
	end

	def support
		Contact.delay.send_mail(current_user)
		flash[:notice] = "Sending mail"
		redirect_to root_url
	end
end
