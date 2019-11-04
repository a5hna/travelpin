class CreateDaySchedules < ActiveRecord::Migration[6.0]
  def change
    create_table :day_schedules do |t|
      t.date :date
      t.text :notes
      t.references :experience, null: false, foreign_key: true

      t.timestamps
    end
  end
end
