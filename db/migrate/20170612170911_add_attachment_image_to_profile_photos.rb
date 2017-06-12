class AddAttachmentImageToProfilePhotos < ActiveRecord::Migration
  def self.up
    change_table :profile_photos do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :profile_photos, :image
  end
end
