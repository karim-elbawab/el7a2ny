class CommentsController < ApplicationController
 def create
   @comment = Comment.new(comment_params)
   @comment.comment_owner = current_user.id
   @comment.save
   offer = Offer.find(@comment.group_id)
   if offer.admin_id != current_user.id
      notification = Notification.create(:user1_id => offer.admin_id, :user2_id => current_user.id, :offer_id => offer.id, :category => 'comment', :seen => false)
      notification.save 
   end
   redirect_to offer_path(offer)
 end
 
 def destroy
  @comment = Comment.find(params[:id])
  offer = Offer.find(@comment.group_id)
  @comment.destroy
  redirect_to offer_path(offer)

 end

 def update
  @comment = Comment.find(params[:id])
  offer = Offer.find(@comment.group_id)
  @comment.update(:private => true)
  redirect_to offer_path(offer)

 end
 
 protected
  def comment_params
    params.require(:comment).permit(:group_id, :description, :attach, :private)
  end   	

end	