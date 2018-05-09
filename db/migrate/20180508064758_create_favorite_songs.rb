class CreateFavoriteSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_songs do |t|
      t.references :favorite, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
