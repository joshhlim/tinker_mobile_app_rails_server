class CreateRequestPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :request_photos do |t|
      t.string :url
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
