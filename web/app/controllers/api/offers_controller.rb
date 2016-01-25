class Api::OffersController < Api::BaseController
	
 def index
   all_offers = Offer.all
   @offers = Array.new()
   all_offers.each do |f|
      if f.private == false
            @offers << Offer.find(f.id)
      end   
   end   
   respond_with @offers
 end

 def new
   @offer= Offer.new
   respond_with @offer
 end

 def create
   @offer = Offer.new(offer_params)
   @offer.admin_id = current_user.id
   @offer.save
   if @offer.private == true
  	 respond_with @offer
   else
  	 respond_with @offer
   end	
 end

 def show
   @offer = Offer.find(params[:id])
   @comments = @offer.comments
   @comment = Comment.new
   @reply = Reply.new
   respond_with @offer
 end

 def edit
   @offer = Offer.find(params[:id])
   respond_with @offer
 end

 def update
 	@offer = Offer.find(params[:id])
	@offer.update(offer_params)
	respond_with @offer
   
 end

 def destroy
 	@offer = Offer.find(params[:id])
 	@offer.destroy

	respond_with @offer

 end

 def private_list
   @offer = Offer.find(params[:id])
   @users = User.all
   respond_with @offer
   respond_with @users
 end

 def offer_members
   @offer = Offer.find(params[:id])
   @users = @offer.users
   respond_with @offer
   respond_with @users
 end 

 protected
	def offer_params
		params.require(:offer).permit(:name ,:photo,:description,:category,:attachment, :reports, :notifications, :admin_id, :private)
	end


 

end	