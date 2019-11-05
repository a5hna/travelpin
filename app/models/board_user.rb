class BoardUser < ApplicationRecord
  belongs_to :user
  belongs_to :board

  validates :user_id, presence: true, uniqueness: { scope: :board, message: "User already member of this board" }
  validates :board_id, presence: true
end
