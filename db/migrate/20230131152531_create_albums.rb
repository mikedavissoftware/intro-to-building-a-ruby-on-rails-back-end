class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :artist
      t.integer :release_year

      t.timestamps
    end
  end
end
