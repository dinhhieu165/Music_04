class Comment < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :song
  scope :order_created_at, -> {order created_at: :desc}

  def self.find_comment commentable_id, commentable_type
    where(commentable_id: commentable_id, commentable_type: commentable_type)
      .includes(:user)
  end
end
