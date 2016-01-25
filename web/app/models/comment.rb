class Comment < ActiveRecord::Base
	
	validates :description, presence: true
	belongs_to :offer
	belongs_to :user
	has_many :replies, :class_name => "Reply", :foreign_key => "comment_id"

	mount_uploader :attach, AttachmentUploader
end
