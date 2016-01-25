class Api::SessionsController < Api::BaseController
	
	def create_facebook
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_path
    end

	def create
		respond_with @user = User.authenticate(*session_params.values_at(:email,:password))
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
