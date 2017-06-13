class DropUrlColumnFromProfilePhotos < ActiveRecord::Migration[5.1]
  def change
    remove_column :profile_photos, :url, :string
  end
end
