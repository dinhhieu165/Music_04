class FavoriteSong < ApplicationRecord
  belongs_to :favorite
  belongs_to :song
end
