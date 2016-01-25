class Offer < ActiveRecord::Base
	
	validates :name, presence: true
	validates :category, presence: true
	validates :description, presence: true
	
	belongs_to :user
	has_many :comments, :class_name => "Comment", :foreign_key => "group_id"
    has_many :invitations, :class_name => "Invitation", :foreign_key => "offer_id"
    has_many :users, :through => :invitations
    has_many :replies, :through => :comments

    mount_uploader :photo, ImageUploader
    mount_uploader :attachment, AttachmentUploader
end
