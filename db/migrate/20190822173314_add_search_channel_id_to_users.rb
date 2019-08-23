class AddSearchChannelIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :search_channel_id, :string
  end
end
