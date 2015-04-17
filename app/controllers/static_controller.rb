class StaticController < ApplicationController
	def index
		@posts = Post.order("created_at DESC").all.paginate(page: params[:page], per_page: 10)
	end
end
