class Api::PostsApiController < ApplicationController
	def index
		@user = User.find(params[:id])
		@posts = @user.posts

		render json: @posts
	end
end
