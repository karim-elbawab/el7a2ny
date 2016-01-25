class Api::BaseController < ApplicationController
	skip_before_action :verify_authenticity_token
	respond_to :json
protected
	helpers	do
		def current_user
			@current_user ||= User.find_by(token: request.headers[:authorization])
		end
		helper_method :current_user

		def current_user?
			current_user.present?
		end
		helper_method :current_user?
		
		def authenticate_user!
			unless current_user?
				render status: :unauthorized
			end
		end
	end	
end
