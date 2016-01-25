class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :name
      t.string :photo
      t.string :description
      t.string :category
      t.string :attachment
      t.integer :reports
      t.integer :notifications
      t.integer :admin_id
      t.boolean :private

      t.timestamps
    end
  end
end
