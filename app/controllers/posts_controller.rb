class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]

	def new
		
	end

	def create
		@user = User.find(current_user._id)
		@post = Post.create(post_params)
		@post.hostuser = @user
		if @post.save
			flash[:notice] = "you have successfully created an meetup!"
			flash[:color] = "valid"

			@user.hostedposts << @post

			#redirect to post view
			redirect_to @post 
		else
			flash[:alert] = "Somthing wrong when creating your account, please check your form and try again."
			flash[:color] = "invalid"

			render create
		end

		# render :text => post_params.inspect

		# redirect_to @post
	end

	def show
		# @post = Post.find({_id: Moped::BSON::ObjectId(params[:id])})
		@posts = Post.find(params[:id])

		# render :text => @post.inspect
	end

	def index
	  @posts = Post

	  @user = User.find(current_user._id)
	  @userJoinedPosts = @user.joinedpost_ids
	  @userHostedPosts = @user.hostedpost_ids
	end	

	def joinedposts
	  @user = User.find(current_user._id)

	  @posts = @user.joinedposts

	  @userJoinedPosts = @user.joinedpost_ids
	  @userHostedPosts = @user.hostedpost_ids
	  # render :text => @posts.inspect
	end

	def hostedposts
	  @user = User.find(current_user._id)

	  @posts = @user.hostedposts

	  @userJoinedPosts = @user.joinedpost_ids
	  @userHostedPosts = @user.hostedpost_ids
	  # render :text => @posts.inspect
	end

  private
	
	def post_params
		params.require(:post).permit(
			:title, 
			:text, 
			:minute, 
			:hour, 
			:date, 
			location:[:name, :address, :approx_address, :lat, :lng], 
			streetview:[:heading, :pitch, :key, :lat, :lng, :zoom]
		)		
	end	
end
