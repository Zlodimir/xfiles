class AddAssetToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :asset, :string
  end
end
