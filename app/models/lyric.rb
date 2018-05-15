class Lyric < ApplicationRecord
  belongs_to :user
  belongs_to :song
  validates :content, presence: true
  scope :is_accepted, -> {
    where accepted: true
  }
  scope :desc_at_create, ->{order created_at: :desc}
  scope :search, -> search{
    where "content LIKE ?", "%#{search}%"
  }
end
