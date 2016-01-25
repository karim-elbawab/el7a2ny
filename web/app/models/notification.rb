class Notification < ActiveRecord::Base
	belongs_to :user
	belongs_to :notification_source, :class_name => "User", :foreign_key => "user2_id"
	belongs_to :offer, :class_name => "Offer", :foreign_key => "offer_id"
end
