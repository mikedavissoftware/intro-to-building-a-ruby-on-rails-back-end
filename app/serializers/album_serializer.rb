class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :release_year
  has_many :music_fans
end
