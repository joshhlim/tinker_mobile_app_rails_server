class AddAttachmentImageToRequestPhotos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :request_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :request_photos, :image
  end
end
