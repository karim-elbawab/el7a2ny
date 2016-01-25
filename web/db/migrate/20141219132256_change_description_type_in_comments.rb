class ChangeDescriptionTypeInComments < ActiveRecord::Migration
   def up
    change_column :comments, :description, :text
  end

  def down
    change_column :comments, :description, :string
  end
end
