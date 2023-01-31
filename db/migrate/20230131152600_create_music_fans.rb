class CreateMusicFans < ActiveRecord::Migration[7.0]
  def change
    create_table :music_fans do |t|
      t.string :name

      t.timestamps
    end
  end
end
