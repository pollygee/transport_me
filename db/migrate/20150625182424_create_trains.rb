class CreateTrains < ActiveRecord::Migration
  def change
    create_table :trains do |t|
      t.text :name
      t.string :address
      t.text :code
      t.integer :latitude
      t.integer :longitude

      t.timestamps null: false
    end
  end
end
