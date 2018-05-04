class Category < ApplicationRecord
  has_many :songs, dependent: :destroy
  scope :load_all, ->{select(:title).order :title}
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, -> search{
    where "title LIKE ?", "%#{search}%"
  }
end
