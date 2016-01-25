collection @notifications, :root => false, :object_root => false
attributes :id, :user1_id, :user2_id, :offer_id, :category, :seen, :created_at, :updated_at
child :offer, :root => false, :object_root => false do
    attribute :id, :name, :description, :category, :reports, :admin_id, :private, :image, :attach, :created_at, :updated_at
end
child :notification_source, :root => false, :object_root => false do
    attribute :id, :name, :email, :token, :provider, :uid, :first_name, :last_name, :city, :country, :birth_date, :profile_picture_url, :gender, :reports_counter, :encrypted_password, :created_at, :updated_at
end 