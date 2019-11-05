class RemoveExperienceFromDaySchedules < ActiveRecord::Migration[6.0]
  def change
    remove_reference :day_schedules, :experience, null: false, foreign_key: true
  end
end
