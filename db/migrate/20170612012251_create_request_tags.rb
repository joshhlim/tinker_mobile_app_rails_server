class CreateRequestTags < ActiveRecord::Migration[5.1]
  def change
    create_table :request_tags do |t|
      t.string :name
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
