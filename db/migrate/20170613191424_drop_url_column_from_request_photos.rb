class DropUrlColumnFromRequestPhotos < ActiveRecord::Migration[5.1]
  def change
    remove_column :request_photos, :url, :string
  end
end
