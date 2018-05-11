class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album
  belongs_to :category

  scope order_by_name: ->{order created_at: :desc}
  scope search_by_name: -> search{
    select(:id, :name).where "name LIKE ?", "%#{search}%"
  }
end
