class Album < ApplicationRecord
  has_many :ratings, dependent: :destroy
  has_many :music_fans, through: :ratings
end
