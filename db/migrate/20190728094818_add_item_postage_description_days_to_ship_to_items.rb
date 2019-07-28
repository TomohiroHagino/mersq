class AddItemPostageDescriptionDaysToShipToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_postage, :string
    add_column :items, :item_description, :string
    add_column :items, :item_days_to_ship, :string
  end
end
