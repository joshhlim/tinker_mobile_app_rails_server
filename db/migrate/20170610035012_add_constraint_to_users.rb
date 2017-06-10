class AddConstraintToUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :username, :string, uniqueness: true, presence: true, limit: 30
  end
end
