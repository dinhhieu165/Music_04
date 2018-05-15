class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :audio
      t.references :album, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
