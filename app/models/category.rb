class Category < ApplicationRecord
  has_many :songs, dependent: :destroy

  scope :load_all, -> { select(:title).order(:title) }
end
