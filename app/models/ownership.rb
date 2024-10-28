class Ownership < ApplicationRecord

  validates :dog_id, presence: true
  validates :owner_id, presence: true

  
  belongs_to :dog
  belongs_to :owner
end
