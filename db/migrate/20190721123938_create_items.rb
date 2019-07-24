class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :item_title
      t.string :item_url
      t.integer :estimated_price

      t.timestamps
    end
  end
end
