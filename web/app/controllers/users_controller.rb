class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :history]

	def other_users
		@users = User.all
	end

	def show
		@user = current_user	
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if User.find_by(email: @user.email).nil?  
	        if @user.confirm_password == @user.password   
				if @user.save
					redirect_to root_path, notice: 'Welcome! Please login.'
				else
					render action: :new
				end
			else
				flash[:alert] = "Your password didn't match with your confirm password"
				render action: :new  
			end
		else
			flash[:alert] = "This email is already used"
			render action: :new
		end		
	end

	def edit
		@user = current_user
	end

	def update
		@user = current_user
		@user.update(user_params)

		redirect_to @user
	end
	
	def my_friends	
		 @users = current_user.friends
	end
	
	def pending_friends
		@users = current_user.pending_friends	
	end	

	def requested_friends
		@users = current_user.requested_friends
	end

	def show_other_user
		@user = User.find(params[:id])
	end

	def users_friends
		@user = User.find(params[:id])
	end

	def my_offers
 	  @offers = current_user.offers.all
    end

    def my_friends_offers
      @users = current_user.friends.all
    end

    def my_notifications
      #@notifications = Notification.find_all_by_user1_id(current_user)	
      @notifications = current_user.notifications.all
    end

protected
	def user_params
		params.require(:user).permit(:name, :email, :password, :confirm_password, :first_name, :last_name, :city, :country, :birth_date,:profile_picture_url, :gender)
	end
	
end
