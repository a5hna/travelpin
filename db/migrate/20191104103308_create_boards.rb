class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :place
      t.string :longitude
      t.string :latitude
      t.string :title
      t.string :description
      t.string :current_weather
      t.string :current_exchange_rate

      t.timestamps
    end
  end
end
