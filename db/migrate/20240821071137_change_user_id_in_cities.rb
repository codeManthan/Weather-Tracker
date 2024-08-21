class ChangeUserIdInCities < ActiveRecord::Migration[7.0]
  def change
    change_column_null :cities, :user_id, false
  end
end
