class CreateLyrics < ActiveRecord::Migration[5.1]
  def change
    create_table :lyrics do |t|
      t.string :content
      t.boolean :accepted, default: false
      t.references :user, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
