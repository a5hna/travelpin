class RenameFriendsToConnections < ActiveRecord::Migration[6.0]
  def change
    rename_table :friends, :connections
  end
end
