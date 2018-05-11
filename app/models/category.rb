class Category < ApplicationRecord
  validates :name, presence: true
  has_many :songs, dependent: :destroy

  scope :load_all, ->{select(:id, :name, :describe).order :name}
  scope :order_by_name, ->{order created_at: :desc}
  scope :search_by_name, -> search{
    select(:id, :name).where "name LIKE ?", "%#{search}%"
  }
end
