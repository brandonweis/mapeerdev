class ApplicationController < ActionController::Base
  	Mongoid.load!("config/mongoid.yml")
  	helper_method :current_user
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	

	def signed_in_user
		unless signed_in?
		  redirect_to root_url+"log_in", notice: "Please sign in."
		end
	end

	private
		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end

	  	def signed_in?
			User.find(session[:user_id]) if session[:user_id]
		end

end
