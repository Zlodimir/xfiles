class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.text :description
      t.references :xfile, index: true, foreign_key: true

      t.timestamps null: false
    end
    #add_foreign_key :notes, :xfile
  end
end
