class Restaurant < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged  
  has_many :plates
  validates :name, presence: true
end
