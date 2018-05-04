class Lyric < ApplicationRecord
  belongs_to :user
  belongs_to :song
  scope :desc_at_create, ->{order created_at: :desc}
end
