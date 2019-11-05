class AddHomeLocationToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :home_location, :string
    add_column :users, :string, :string
  end
end
