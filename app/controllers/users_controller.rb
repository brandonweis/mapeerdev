class UsersController < ApplicationController
	def new
	end

	def create

		# render text: user_params.inspect

		# @user = User.find_by(email: user_params.email)
		# # @user = User.findByEmail(user_params.email)

		# if @user 
		# 	flash[:alert] = "You have registered with us before."
		# 	flash[:color] = "invalid"

		# 	render "login"
		# end

		@user = User.create(user_params)

		if @user.save
			flash[:notice] = "you have successfully created an account for yourself!"
			flash[:color] = "valid"
		else
			flash[:alert] = "Somthing wrong when creating your account, please check your form and try again."
			flash[:color] = "invalid"
		end

		render new

		# redirect_to @user
	end

	def edit
		@user = User.find(current_user._id)
	end

	def update
		@user = User.find(current_user._id)
   		@user.update_attributes!(user_params)
		# render :text => user_params.inspect
		flash[:notice] = "Successfully updated your profile!"
		flash[:color] = "valid"
		render "users/edit"
	end

  private
  	def user_params

  		params.require(:user).permit(:name, :bio, :gender, :email, :password, :password_confirm)
  	end

end
