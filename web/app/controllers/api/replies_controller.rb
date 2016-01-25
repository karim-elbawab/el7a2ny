class Api::RepliesController < Api::BaseController
 def create
   @reply = Reply.new(reply_params)
   @reply.reply_owner = current_user.id
   @reply.save
   respond_with @reply
   comment = Comment.find(@reply.comment_id)
   offer = Offer.find(comment.group_id)
   respond_with comment
   respond_with offer
   if offer.admin_id != current_user.id
     notification = Notification.create(:user1_id => offer.admin_id, :user2_id => current_user.id, :offer_id => offer.id, :category => 'reply1', :seen => false)
     if offer.admin_id != comment.comment_owner
      if comment.comment_owner != current_user.id
        notification = Notification.create(:user1_id => comment.comment_owner, :user2_id => current_user.id, :offer_id => offer.id, :category => 'reply2', :seen => false)
      end     
     end
     notification.save  
   end
 end
 
 def destroy
  @reply = Reply.find(params[:id])
  respond_with @reply
  comment = Comment.find(@reply.comment_id)
  offer = Offer.find(comment.group_id)
  respond_with comment
  respond_with offer
  @reply.destroy
 end
 
 protected
  def reply_params
    params.require(:reply).permit(:comment_id, :description)
  end   	

end	