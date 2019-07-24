class AddItemPriceToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_price, :integer
  end
end
