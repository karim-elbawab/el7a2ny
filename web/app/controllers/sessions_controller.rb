class SessionsController < ApplicationController
	
	def create_facebook
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
    end

	def create
		email, password = session_params.values_at(:email, :password)
		if user = User.authenticate(email, password)
			session[:user_id] = user.id
			redirect_to root_path, notice: "Welcome, #{user.name}"
		else
			redirect_to root_path, alert: 'Invalid email or password'

		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to root_path, notice: 'Goodbye!'
	end

protected

	def session_params
		params.require(:session).permit(:email, :password)	
	end	
end	
