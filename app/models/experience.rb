class Experience < ApplicationRecord
  belongs_to :board
  belongs_to :user
  belongs_to :category
end
