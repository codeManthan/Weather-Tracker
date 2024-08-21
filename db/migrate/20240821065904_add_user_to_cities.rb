class AddUserToCities < ActiveRecord::Migration[7.0]
  def change
    add_reference :cities, :user, null: true, foreign_key: true
  end
end
