class InvitationsController < ApplicationController
	def create
	   invitation = Invitation.new(invitation_params)
	   invitation.save
	   notification = Notification.create(:user1_id => invitation.user_id, :user2_id => current_user.id, :offer_id => invitation.offer_id, :category => 'private offer', :seen => false)
	   notification.save
	   @offer = Offer.find(invitation.offer_id)
	   redirect_to private_list_offer_path(@offer)	
	end

	def destroy
	  @invitation = Invitation.find(params[:id])
	  offer = Offer.find(@invitation.offer_id)
	  @invitation.destroy
	  redirect_to offer_members_offer_path(offer)
 	end

protected
  
  	def invitation_params
    	params.require(:invitation).permit(:offer_id, :user_id)
  	end
end	