class CreateBoardUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :board_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.boolean :admin

      t.timestamps
    end
  end
end
