class RatingSerializer < ActiveModel::Serializer
  attributes :id, :score
  has_one :music_fan
  has_one :album
end
