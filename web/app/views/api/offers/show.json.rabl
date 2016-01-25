object @offer => nil
attributes :id, :name, :description, :category, :reports, :admin_id, :private, :image, :attach, :created_at, :updated_at

child :comments, :root => false, :object_root => false do
    attribute :comment_owner, :group_id, :description, :attach, :reports, :created_at, :updated_at, :private, :attachment

    child :replies, :root => false, :object_root => false do
    	attribute :reply_owner, :comment_id, :description, :created_at, :updated_at
   	end

end 
