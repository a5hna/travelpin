class DaySchedule < ApplicationRecord
  has_many :day_schedule_items
  has_many :experiences, through: :day_schedule_items
  # has_one :board, through: :experiences
  belongs_to :board

  validates :date, presence: true , uniqueness: { scope: :board }

end
