class Expertship < ApplicationRecord
  belongs_to :user, :foreign_key => "user_id", :class_name => "User"
  belongs_to :expert, :foreign_key => "expert_id", :class_name => "User"
end
