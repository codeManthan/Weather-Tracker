class CreateTemperatures < ActiveRecord::Migration[7.0]
  def change
    create_table :temperatures do |t|
      t.float :temperature
      t.datetime :recorded_at

      # extra info
      t.string :icon
      t.float :humidity
      t.float :wind_speed

      t.references :city, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end