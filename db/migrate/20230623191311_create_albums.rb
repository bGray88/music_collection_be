class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :release_year, null: false
      t.string :genre, null: false
      t.string :api_id, null: false, index: { unique: true }
      t.string :image

      t.timestamps
    end
  end
end
