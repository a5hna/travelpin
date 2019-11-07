class AddCountryToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :country, :string
  end
end
