class AddAuthorIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :author_id, :integer
  end
end
