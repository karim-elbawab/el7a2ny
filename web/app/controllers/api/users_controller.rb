class Api::UsersController < Api::BaseController
	before_action :authenticate_user!, only: [:show, :history]

	def other_users
		@users = User.all
		respond_with @users
	end

	def show
		respond_with @user = current_user	
	end

	def new
		respond_with @user = User.new
	end

	def create
		@user = User.new(user_params)
		respond_with @user		
	end

	def edit
		respond_with @user = current_user
	end

	def update
		@user = current_user
		@user.update(user_params)

		respond_with @user
	end
	
	def my_friends	
		friendships = Friendship.all
		@users = Array.new(friendships.length)
		friendships.each do |f|
			if f.user_id == User.find(params[:id]).id && f.status == 'accepted'
				@users << User.find(f.friend_id)
			end	
		end	
		@users.each do |f|
			if f == nil
				@users.delete(f)
			end	
		end	
		respond_with @users
		
	end
	
	def pending_friends
		respond_with @users = current_user	
	end	

	def requested_friends
		respond_with @users = current_user
	end

	def show_other_user
		respond_with @user = User.find(params[:id])
	end

	def users_friends
		respond_with @user = User.find(params[:id])
	end

	def my_offers
 	  respond_with @offers = current_user.offers.all
    end

    def my_friends_offers
      respond_with @users = current_user.friends.all
    end

    def my_notifications
      @notifications = Notification.find_all_by_user1_id(User.find(params[:id]))
      respond_with @notifications
    end

protected
	def user_params
		params.require(:user).permit(:name, :email, :password, :confirm_password, :first_name, :last_name, :city, :country, :birth_date,:profile_picture_url, :gender)
	end
	
end
