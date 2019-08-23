class AddImageUrlToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :item_image1, :string
    add_column :items, :item_image2, :string
    add_column :items, :item_image3, :string
    add_column :items, :item_image4, :string
    add_column :items, :item_image5, :string
    add_column :items, :item_image6, :string
    add_column :items, :item_image7, :string
    add_column :items, :item_image8, :string
    add_column :items, :item_image9, :string
    add_column :items, :item_image10, :string
  end
end
