class AddItemImageToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_image, :string
  end
end
