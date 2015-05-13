class Api::PostsApiController < ApplicationController
	before_action :doorkeeper_authorize!
	def index	
		@user = User.find(params[:id])
		@posts = @user.posts

		render json: @posts
	end
end
