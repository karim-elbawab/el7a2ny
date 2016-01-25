class ChangeDescriptionTypeInOffers < ActiveRecord::Migration
  def up
    change_column :offers, :description, :text
  end

  def down
    change_column :offers, :description, :string
  end
end
