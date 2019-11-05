class Experience < ApplicationRecord
  belongs_to :board
  belongs_to :user
  belongs_to :category
  has_many :day_schedule_items
  has_many :day_schedules, through: :day_schedule_items

  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :title, presence: true
  validates :photo, presence: true
  validates :user_id, presence: true
  validates :category_id, presence: true
end
