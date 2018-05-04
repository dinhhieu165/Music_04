class Album < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :artist
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, ->search{
    where "name LIKE ?", "#{search}"
  }
end
