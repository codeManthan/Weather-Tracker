class AddMainlineAndDescriptionToTemperatures < ActiveRecord::Migration[7.0]
  def change
    add_column :temperatures, :mainline, :string
    add_column :temperatures, :description, :string
  end
end
