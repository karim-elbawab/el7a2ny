class Api::CommentsController < Api::BaseController
 before_action :authenticate_user!
 def create
   @comment = Comment.new(comment_params)
   @comment.comment_owner = User.find(params[:id]).id
   @comment.save
   respond_with @comment
   offer = Offer.find(@comment.group_id)
   if offer.admin_id != User.find(params[:id]).id.id
      notification = Notification.create(:user1_id => offer.admin_id, :user2_id => User.find(params[:id]).id, :offer_id => offer.id, :category => 'comment', :seen => false)
      notification.save 
   end
 end
 
 def destroy

  @comment = Comment.find(params[:id])
  offer = Offer.find(@comment.group_id)
  respond_with @comment
  @comment.destroy

 end
 
 protected
  def comment_params
    params.require(:comment).permit(:group_id, :description, :attach, :private)
  end   	

end	
