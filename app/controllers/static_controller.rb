class StaticController < ApplicationController
	def index
		@posts = Post.order("created_at DESC").all.paginate(page: params[:page], per_page: 10)
	end

	def share
		post = Post.find(params[:id])
		user = post.user
		@users = User.all_except([current_user, user])
		emails = @users.each.map { |e| e.email  }
		Delayed::Job.enqueue(MailJob.new(current_user, emails, user, post))
		flash[:notice] = "Sending mail"
		redirect_to root_url
	end

	def support
		Contact.send_mail(current_user).deliver
		flash[:notice] = "Mail sent. will get back to you shortly."
		redirect_to :back
	end
end
