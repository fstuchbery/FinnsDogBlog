class Owner < ApplicationRecord
    validates :name, presence: true
    validates :age, presence: true, numericality: { only_integer: true, greater_than: 0 }
    has_many :ownerships
    has_many :dogs, through: :ownerships
end
