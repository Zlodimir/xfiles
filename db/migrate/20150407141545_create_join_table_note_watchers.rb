class CreateJoinTableNoteWatchers < ActiveRecord::Migration
  def change
    create_join_table :notes, :users, table_name: :note_watchers do |t|
       t.index [:note_id, :user_id]
       t.index [:user_id, :note_id]
    end
  end
end
