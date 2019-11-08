class AddBoardReferencesToDaySchedule < ActiveRecord::Migration[6.0]
  def change
    add_reference :day_schedules, :board, null: false, foreign_key: true
  end
end
