class User < ActiveRecord::Base
	
	attr_accessor :password
    attr_accessor :confirm_password
    
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_create -> { self.token = SecureRandom.hex }, unless: :token?
	before_save :encrypt_password, if: -> {self.password.present? }
	validates :name, presence: true
	validates :email, presence: true, format: { with: EMAIL_REGEX }, uniqueness: true, length: { minimum: 6 }, on: :create
	validates :password, presence: true, length: { minimum: 6 }, on: :create

	mount_uploader :profile_picture_url, ImageUploader

	has_many :invitations
	has_many :private_offers, :through => :invitations, :source => :offer
	has_many :offers, :class_name => "Offer", :foreign_key => "admin_id"
	has_many :comments, :class_name => "Comment", :foreign_key => "comment_owner"
	has_many :replies, :class_name => "Reply", :foreign_key => "reply_owner"
	has_many :friends, :through => :friendships, :conditions => "status = 'accepted'"
	has_many :requested_friends, :through => :friendships, :source => :friend, :conditions => "status = 'requested'", :order => :created_at
	has_many :pending_friends, :through => :friendships, :source => :friend, :conditions => "status = 'pending'", :order => :created_at
	has_many :friendships
	has_many :notifications, :class_name => "Notification", :foreign_key => "user1_id"
	has_many :users_notifications, :through => :notifications, :source => :notification_source
	#has_many :friendships
	#has_many :users, through: :friendships

	def self.from_omniauth(auth)
      where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        if auth.info.location.present?
	        if auth.info.location.include? ","
	        	first, *rest = auth.info.location.split(/, /)
	        	user.city = first
	        	user.country = rest
	        else
	        	user.country = auth.info.location
	        end
	    end    
	    user.token = auth.credentials.token
        user.profile_picture_url = auth.info.image
        user.gender = auth.extra.raw_info.gender
        user.birth_date = Date.strptime(auth.fetch('extra', {}).fetch('user_hash', {})['birthday'],'%m/%d/%Y') if auth.fetch('extra', {}).fetch('user_hash', {})['birthday']
            if auth.fetch('extra', {}).fetch('user_hash', {})['timezone']
              utc_offset_in_hours = (auth.fetch('extra', {}).fetch('user_hash', {})['timezone']).to_i 
              time_zone = (ActiveSupport::TimeZone[utc_offset_in_hours]).name
            else
              time_zone = nil
            end	
        user.save!(:validate => false)
      end
    end

	def self.authenticate(email, password)
		if email.present? && password.present?
			if user = User.find_by(email: email)
				if user.valid_password?(password)
					user
				end
			end	
		end	
	end

	def self.confirm_password
		password == confirm_password		
	end	

	def valid_password?(password)
		self.encrypted_password == Digest::MD5.hexdigest(password)
	end

	def encrypt_password
		self.encrypted_password = Digest::MD5.hexdigest(password)
	end
end
