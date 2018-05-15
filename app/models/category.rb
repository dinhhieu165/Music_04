class Category < ApplicationRecord
  validates :title, presence: true
  has_many :songs, dependent: :destroy

  scope :load_all, ->{select(:id, :title, :describe).order :title}
  scope :order_by_name, ->{order created_at: :desc}
  scope :search_by_name, -> search{
    select(:id, :title).where "title LIKE ?", "%#{search}%"
  }
end
