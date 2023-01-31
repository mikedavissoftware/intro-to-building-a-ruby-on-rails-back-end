class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :release_year
end
