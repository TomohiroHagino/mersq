class AddReferencesUserIdToYoutube < ActiveRecord::Migration[5.2]
  def change
    add_reference :youtubes, :user, foreign_key: true
  end
end
