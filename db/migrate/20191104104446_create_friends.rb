class CreateFriends < ActiveRecord::Migration[6.0]
  def change
    create_table :friends do |t|
      t.references :user_one, index: true, foreign_key: {to_table: :users}
      t.references :user_two, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
