class RemoveCoordsFromBoards < ActiveRecord::Migration[6.0]
  def change
     remove_column :boards, :latitude
  remove_column :boards, :longitude
  end
end
