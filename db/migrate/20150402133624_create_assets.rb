class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :asset
      t.references :note, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
