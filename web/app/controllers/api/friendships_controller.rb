class Api::FriendshipsController < Api::BaseController
 
  def create
    @friendship1 = Friendship.create(friendship1_params)
    @friendship2 = Friendship.create(friendship2_params)
    respond_with @friendship1
    respond_with @friendship2
    if @friendship1.save && @friendship2.save
      flash[:notice] = "Your request has been sent"
      redirect_to root_path(current_user)
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_path(current_user)
    end
  end
  
  def update
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id ])
    respond_with @user
    respond_with @friend
    @friendship1 = Friendship.find_by_user_id_and_friend_id(@user.id, @friend.id)
    @friendship2 = Friendship.find_by_user_id_and_friend_id(@friend.id, @user.id)
    respond_with @friendship1
    respond_with @friendship2
    if @friendship1.update_attributes(friendship1_update_params) && @friendship2.update_attributes(friendship2_update_params)
      notification = Notification.create(:user1_id => @friend.id, :user2_id => @user.id, :offer_id => 0, :category => 'friendship accept', :seen => false)
      notification.save
      flash[:notice] = 'Friend sucessfully accepted!'
      redirect_to root_path(current_user)
    else
      redirect_to root_path(current_user)
    end
  end

  def destroy
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id ])
    @friendship1 = @user.friendships.find_by_friend_id(params[:friend_id ]).destroy
    @friendship2 = @friend.friendships.find_by_user_id(params[:friend_id ]).destroy
    respond_with @user
    respond_with @friend
    respond_with @friendship1
    respond_with @friendship2
    flash[:notice] = "Removed friendship."
    redirect_to root_path(:user_id => current_user)
  end
    
protected
  def friendship1_params
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => 'requested'}
    params.require(:friendship1).permit(:user_id, :friend_id, :status)
  end
  def friendship2_params
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => 'pending'}
    params.require(:friendship2).permit(:user_id, :friend_id, :status)
  end
  def friendship1_update_params
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    params[:friendship1] = {:user_id => @user.id, :friend_id => @friend.id, :status => 'accepted'}
    params.require(:friendship1).permit(:user_id, :friend_id, :status)
  end
  def friendship2_update_params
    @user = User.find(current_user)
    @friend = User.find(params[:friend_id])
    params[:friendship2] = {:user_id => @friend.id, :friend_id => @user.id, :status => 'accepted'}
    params.require(:friendship2).permit(:user_id, :friend_id, :status)
  end

end

