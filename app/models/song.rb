class Song < ApplicationRecord
  belongs_to :album
  belongs_to :category
  validates :name, presence: true
  has_many :lyric, dependent: :destroy
  has_many :favorites, through: :favorite_song
  has_many :rates, dependent: :destroy
  has_attached_file :image, :styles => {small: Settings.song.style}
  validates_attachment :image,
                       content_type: {content_type: /\Aimage\/.*\z/},
                       size: { less_than: 1.megabyte}

  has_attached_file :audio
  validates_attachment :audio,
                       content_type: { content_type: [ "audio/x-mpeg", "audio/x-mp3", "audio/mp3", "audio/mpeg"] },
                       size: { less_than: 100.megabytes}

  scope :desc_at_create, ->{order(created_at: :desc)}
  scope :search, ->search{
    where "name LIKE ?", "%#{search}%"
  }
end
