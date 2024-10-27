class Dog < ActiveRecord::Base
  has_many :ownerships
  has_many :owners, through: :ownerships
  belongs_to :breed
end
