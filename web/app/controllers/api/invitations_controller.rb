class Api::InvitationsController < Api::BaseController
	def create
	   invitation = Invitation.new(invitation_params)
	   invitation.save
	   notification = Notification.create(:user1_id => invitation.user_id, :user2_id => current_user.id, :offer_id => invitation.offer_id, :category => 'private offer', :seen => false)
	   notification.save
	   @offer = Offer.find(invitation.offer_id)
	   respond_with @offer
	   respond_with invitation	
	end

	def destroy
	  @invitation = Invitation.find(params[:id])
	  offer = Offer.find(@invitation.offer_id)
	  respond_with @invitation
	  respond_with offer
	  @invitation.destroy
	end

protected
  
  	def invitation_params
    	params.require(:invitation).permit(:offer_id, :user_id)
  	end
end	