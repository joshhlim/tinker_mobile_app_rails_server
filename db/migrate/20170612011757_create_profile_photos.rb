class CreateProfilePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_photos do |t|
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
