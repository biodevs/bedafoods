class CreatePlates < ActiveRecord::Migration[5.0]
  def change
    create_table :plates do |t|
      t.references :restaurant, foreign_key: true
      t.decimal :price, precision: 18, scale: 2
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
