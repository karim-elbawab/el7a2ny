class OffersController < ApplicationController
	
 def index
   @offers=Offer.all
 end

 def new
   @offer= Offer.new
 end

 def create
   @offer = Offer.new(offer_params)
   @offer.admin_id = current_user.id
   @offer.save
   if @offer.private == true
  	 redirect_to private_list_offer_path(@offer)
   else
  	 redirect_to @offer
   end	
 end

 def show
   @offer = Offer.find(params[:id])
   @comment = Comment.new
   @reply = Reply.new
 end

 def edit
   @offer = Offer.find(params[:id])
 end

 def update
 	@offer = Offer.find(params[:id])
	@offer.update(offer_params)
	redirect_to @offer
   
 end

 def destroy
 	@offer = Offer.find(params[:id])
 	@offer.destroy

	redirect_to root_path

 end

 def private_list
   @offer = Offer.find(params[:id])
   @users = User.all
 end

 def offer_members
   @offer = Offer.find(params[:id])
   @users = @offer.users
 end 

 protected
	def offer_params
		params.require(:offer).permit(:name ,:photo,:description,:category,:attachment, :reports, :notifications, :admin_id, :private)
	end


 

end	