class Board < ApplicationRecord
  has_many :experiences, dependent: :destroy
  has_many :board_users, dependent: :destroy
  has_many :users, through: :board_users
  has_many :day_schedule_items, through: :experiences, dependent: :destroy
  has_many :day_schedules, through: :day_schedule_items, dependent: :destroy

  validates :place, presence: true
  validates :title, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end
