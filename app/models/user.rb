class User < ApplicationRecord
  has_many :lyrics, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
end
