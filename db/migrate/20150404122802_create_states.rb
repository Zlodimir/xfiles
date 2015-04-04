class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :color
      t.string :background

      t.timestamps null: false
    end

    add_column :notes, :state_id, :integer,  index: true
    add_column :comments, :state_id, :integer
  end
end
