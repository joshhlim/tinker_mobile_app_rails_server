class RemoveRequestPhotoIdColumnFromComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :comments, :request_photo_id, :references
  end
end
