class JoinsController < ApplicationController
	before_action :signed_in_user, only: [:create]

	def create
		respond_to do |format|
			@post = Post.find(params[:id])
			# keep storing embedded document without reset and erase previous save array of endded document
			# @joins = @post.joins.create!({:user_id=>current_user._id, :user_name=>current_user.email})

			@user = User.find(current_user._id);

			if !@user.nil?
				@user.joinedposts << @post

				if @user.save!
					format.json { # This block will be called for JSON requests
						render :json => {:error => false, :msg => "joined post #"+params[:id]}
					}
				else
					format.json { # This block will be called for JSON requests
						render :json => {:error => true, :msg => "saving error."}
					}
				end
			else
				format.json { # This block will be called for JSON requests
					render :json => {:error => true, :msg => "not login"}
				}
			end

	    end
		# render :text => current_user.inspect
	end

	def delete
		respond_to do |format|

			@post = Post.find(params[:id])
			@user = User.find(current_user._id)
			@user.joinedposts.delete(@post)
			format.json { # This block will be called for JSON requests
				render :json => {:error => false, :msg => "withdrawn post #"+params[:id]}
			}
		end

	end

end
