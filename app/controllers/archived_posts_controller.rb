require 'will_paginate/array'
class ArchivedPostsController < ApplicationController
  def index
  	@user = User.find(params[:id])
  	if @user == current_user
			@posts = @user.archived_posts.order("created_at DESC").paginate(page: params[:page], per_page: 10)
		else
			redirect_to root_path
		end
  end

  def show
  	@post = ArchivedPost.find(params[:id])
  	@post_comments = @post.archived_comments
  end

  def archive
  	@post = Post.find(params[:id])
  	@archived_post = ArchivedPost.new(title: @post.title, body: @post.body, user_id: @post.user_id, header_image: @post.header_image)
  	if @archived_post.save
  		@post.comments.each do |comment|
  			ArchivedComment.create!(content: comment.content, user_id: comment.user_id, archived_post_id: @archived_post.id)
  		end
  		@post.destroy
  		flash[:success] = "Post archived."
  		redirect_to archived_post_path(@archived_post.id)
  	else
  		flash[:alert] = "Something went wrong, Try againg."
  		redirect_to @post
  	end
  end

  def unarchive
  	@archived_post = ArchivedPost.find(params[:id].to_s)
  	@post = Post.new(title: @archived_post.title, body: @archived_post.body, user_id: @archived_post.user_id, header_image: @archived_post.header_image)
  	if @post.save
  		@archived_post.archived_comments.each do |comment|
  			Comment.create!(content: comment.content, user_id: comment.user_id, post_id: @post.id)
  		end
  		@archived_post.destroy
  		flash[:success] = "Post unarchived"
  		redirect_to @post
  	else
  		flash[:alert] = "Something went wrong, Try againg."
  		redirect_to @archived_post
  	end
  end

  def show_comments
		@post = ArchivedPost.find(params[:id])
		@post_comments = @post.archived_comments
		respond_to do |format|
			format.js
			format.html { redirect_to new_user_session_path }
		end
	end

	def destroy
		ArchivedPost.find(params[:id]).destroy
		redirect_to archived_posts_path(current_user.id)
	end
end
