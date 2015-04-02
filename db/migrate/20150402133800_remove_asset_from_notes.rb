class RemoveAssetFromNotes < ActiveRecord::Migration
  def change
    remove_column :notes, :asset, :string
  end
end
