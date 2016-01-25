class AddAttachToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :attach, :string
  end
end
