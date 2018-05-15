class Favorite < ApplicationRecord
  belongs_to :user
  has_many :favorite_songs, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :comments, dependent: :destroy
end
