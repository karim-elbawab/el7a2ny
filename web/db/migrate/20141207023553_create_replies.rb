class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :reply_owner
      t.integer :comment_id
      t.text :description

      t.timestamps
    end
  end
end
