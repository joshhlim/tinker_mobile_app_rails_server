class CreateExpertships < ActiveRecord::Migration[5.1]
  def change
    create_table :expertships do |t|
      t.integer :user_id
      t.integer :expert_id

      t.timestamps
    end
  end
end
