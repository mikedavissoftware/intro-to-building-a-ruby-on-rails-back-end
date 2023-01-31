class Rating < ApplicationRecord
  belongs_to :music_fan
  belongs_to :album
end
