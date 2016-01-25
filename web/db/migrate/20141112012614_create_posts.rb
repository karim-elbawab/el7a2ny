class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :owner_id
      t.string :description
      t.integer :page_user_id
      t.integer :reports

      t.timestamps
    end
  end
end
