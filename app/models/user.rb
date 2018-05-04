class User < ApplicationRecord
  has_many :lyrics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, ->search{
    where "name LIKE ? or email LIKE ?", "%#{search}%", "%#{search}%"
  }
end
