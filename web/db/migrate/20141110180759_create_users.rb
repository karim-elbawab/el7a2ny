class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :country
      t.date :birth_date
      t.string :profile_picture_url
      t.string :gender
      t.integer :reports_counter, default: 0
      t.string :encrypted_password

      t.timestamps
    end
  end
end
