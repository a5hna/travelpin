class Connection < ApplicationRecord
  belongs_to :user_one, class_name: 'User', foreign_key: :user_one_id
  belongs_to :user_two, class_name: 'User', foreign_key: :user_two_id

  validates :user_one, presence: true, uniqueness: { scope: :user_two }
  validates :user_two, presence: true
end

