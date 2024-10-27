class Owner < ApplicationRecord
    has_many :ownerships
    has_many :dogs, through: :ownerships
end
