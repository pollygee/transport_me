class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :station_id
      t.text :name
      t.decimal :lat
      t.decimal :long

      t.timestamps null: false
    end
  end
end
