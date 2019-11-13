class AddStuffToBoards < ActiveRecord::Migration[6.0]
  def change
    add_column :boards, :ne_lat, :float
    add_column :boards, :ne_lng, :float
    add_column :boards, :sw_lat, :float
    add_column :boards, :sw_lng, :float
    add_column :boards, :level, :string
  end
end
