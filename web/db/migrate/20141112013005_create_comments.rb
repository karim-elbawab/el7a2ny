class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :comment_owner
      t.integer :group_id
      t.string :description
      t.string :attach
      t.integer :reports

      t.timestamps
    end
  end
end
