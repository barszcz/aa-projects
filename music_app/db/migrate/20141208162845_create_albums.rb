class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title, null: false
      t.integer :band_id, null: false

      t.timestamps
    end
    add_index :albums, [:title, :band_id], unique: true
  end
end
