class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_title
      t.string :item_url
      t.integer :item_price
      t.integer :item_good
      t.string :item_type
      t.string :item_category
      t.string :item_brand

      t.timestamps
    end
  end
end
