class MusicFan < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :albums, through: :ratings
end
