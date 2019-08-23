class AddYoutubeApiToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :youtube_api, :string
  end
end
