# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "🎵 Seeding music fans..."
MusicFan.create(name: "Vizmund Cygnus")
MusicFan.create(name: "Cassandra Gemini")
MusicFan.create(name: "Cerpin Taxt")

puts "🎵 Seeding albums..."
Album.create(
  title: "DAMN. COLLECTORS EDITION.",
  artist: "Kendrick Lamar",
  release_year: 2017
)
Album.create(
  title: "In Rainbows",
  artist: "Radiohead",
  release_year: 2007
)
Album.create(
  title: "Monsters Are People",
  artist: "Chess at Breakfast",
  release_year: 2021
)

puts "🎵 Seeding ratings..."
Rating.create(score: 10, music_fan_id: 1, album_id: 2)
Rating.create(score: 9, music_fan_id: 3, album_id: 1)
Rating.create(score: 8, music_fan_id: 2, album_id: 3)
Rating.create(score: 7, music_fan_id: 3, album_id: 3)
Rating.create(score: 6, music_fan_id: 2, album_id: 2)
Rating.create(score: 5, music_fan_id: 1, album_id: 1)

puts "Done seeding!"
