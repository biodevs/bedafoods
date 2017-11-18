class Plate < ApplicationRecord
  belongs_to :restaurant
  validates :restaurant, presence: true
end
