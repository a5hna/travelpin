class DayScheduleItem < ApplicationRecord
  belongs_to :experience
  belongs_to :day_schedule
  has_one :board, through: :experiences


end
