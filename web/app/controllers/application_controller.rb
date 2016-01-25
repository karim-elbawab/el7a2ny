class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected
	def current_user
		@current_user ||= User.find(session[:user_id]) if session.key?(:user_id)  	
	end  
	helper_method :current_user

	def current_user?
		current_user.present?
	end
	helper_method :current_user?

	def authenticate_user!
		redirect_to root_path, alert: 'You have to login first' unless current_user?
	end
end
