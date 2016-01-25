class Reply < ActiveRecord::Base
	
	validates :description, presence: true

	belongs_to :comment
	belongs_to :user
end
