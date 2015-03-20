class CreateXfiles < ActiveRecord::Migration
  def change
    create_table :xfiles do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
