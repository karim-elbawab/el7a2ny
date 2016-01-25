class Friendship < ActiveRecord::Base

  #attr_accessible :friendship1
  #attr_accessible :friendship2

  belongs_to :user
  belongs_to :friend,:class_name => "User", :foreign_key => "friend_id"

end
