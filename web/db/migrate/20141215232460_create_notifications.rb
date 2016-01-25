class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.integer :offer_id
      t.string :category
      t.boolean :seen

      t.timestamps
    end
  end
end
