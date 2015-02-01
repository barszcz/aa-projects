class AddKindAndLyricsToAlbumAndTrack < ActiveRecord::Migration
  def change
    add_column :albums, :kind, :string
    add_column :tracks, :kind, :string
    change_column :albums, :kind, :string, null: false
    change_column :tracks, :kind, :string, null: false
    add_column :tracks, :lyrics, :text
  end
end
