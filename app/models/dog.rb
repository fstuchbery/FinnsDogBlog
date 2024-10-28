class Dog < ActiveRecord::Base
  validates :name, presence: true
  validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }

  has_many :ownerships
  has_many :owners, through: :ownerships
  belongs_to :breed
end
