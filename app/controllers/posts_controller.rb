class PostsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	def index
		@user = User.find(params[:id])
		@posts = current_user.posts.order("updated_at").paginate(page: params[:page], per_page: 10)
	end

	def show
		@post = Post.find(params[:id])
		@post_comments = @post.comments
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

	# def throw_comment
	# 	respond_to do |format|
	# 		format.js
	# 	end
	# end

	def show_comments
		@post = Post.find(params[:id])
		@post_comments = @post.comments
		respond_to do |format|
			format.js
		end
	end

	def create_comment
		@post = Post.find(params[:id])
		@post_comments = @post.comments
		@comment = Comment.new(content: params[:content], user_id: current_user.id, post_id: @post.id)
		if @comment.save!
			respond_to do |format|
				format.js
				format.html { redirect_to posts_path(@post.id) }
			end
		else
			render 'show'
		end
	end
end
