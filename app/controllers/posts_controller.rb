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
	  	@posts = Post.without(:comments)

	  	if !current_user.nil?
		  @user = User.find(current_user._id)
		  @userJoinedPosts = @user.joinedpost_ids
		  @userHostedPosts = @user.hostedpost_ids
		end
	end	

	def joinedposts
		  @user = User.find(current_user._id)

		  @tempposts = @user.joinedposts
		  # @posts = @tempposts.elem_match(comments: { user_id: current_user._id })
		  @posts = @tempposts.where({ :comments => { '$elemMatch' => { :user_name => 'brandon2' } } })
		  # @posts = @tempposts.without(:comments.elem_match => { user_name: "brandon2" })
		  # @posts = @tempposts.find({ "comments" => { $exists => true} } )
		  # @posts = @tempposts

		  # @tempposts.each do |post|
		  # 	@comments = post.comments
		  # 	@comments.find(:user_id => current_user._id)
		  # end

		  @posts = @tempposts
		  # @current_user_id = current_user._id
		  @userJoinedPosts = @user.joinedpost_ids
		  @userHostedPosts = @user.hostedpost_ids
		  # render :text => @posts.to_json
	end

	def hostedposts
		  @user = User.find(current_user._id)

		  @posts = @user.hostedposts

		  @userJoinedPosts = @user.joinedpost_ids
		  @userHostedPosts = @user.hostedpost_ids
		  # render :text => @posts.inspect
	end


	def searchloc
		respond_to do |format|
		  @post = Post.near( "coordinate" => [params[:lng], params[:lat]])
	      
	      if !@post.nil?

        	format.json {
      			# render :template => 'post/index'
      			render :json => {:error => false, :msg => @post.to_json}

        	}
	      else
	      	format.json {
	        	render :json => {:error => true, :msg => "no result"}
	        }
	      end
		end
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
		).merge(:coordinate => [params[:post][:location][:lng], params[:post][:location][:lat]])		
	end	
end
