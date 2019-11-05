class CreateDayScheduleItems < ActiveRecord::Migration[6.0]
  def change
    create_table :day_schedule_items do |t|
      t.references :experience, null: false, foreign_key: true
      t.references :day_schedule, null: false, foreign_key: true

      t.timestamps
    end
  end
end
