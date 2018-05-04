class Artist < ApplicationRecord
  has_many :albums, dependent: :destroy
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, ->search{
    where "name LIKE ?", "%#{search}%"
  }
end
