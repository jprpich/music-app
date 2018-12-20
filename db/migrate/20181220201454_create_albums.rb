class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :year
      t.boolean :live
      t.integer :band_id

      t.timestamps
    end
    add_index :albums, :band_id
  end
end
