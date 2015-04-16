class PostsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	def index
		@posts = current_user.posts.order("updated_at").paginate(page: params[:page], per_page: 10)
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
		post = params[:post]
		@post = Post.new(title: post[:title], body: post[:body], user_id: current_user.id)
		if @post.save!
			redirect_to posts_path
			current_user.posts << @post
		else
			render 'new'
		end
	end

	def destroy
		Post.find(params[:id]).destroy
		redirect_to posts_path
	end
end
