class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false
      t.float :lat, null: false
      t.float :lon, null: false

      t.timestamps
    end
  end
end
