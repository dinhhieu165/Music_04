class Album < ApplicationRecord
  has_many :songs, dependent: :destroy
  belongs_to :artist
  # has_many :rates, dependent: :destroy
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, ->search{
    where "name LIKE ?", "#{search}"
  }

  validates :name, presence: true
end
