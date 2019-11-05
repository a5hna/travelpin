class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :friends, dependent: :destroy
  has_many :board_users, dependent: :destroy
  has_many :boards, through: :board_users
  has_many :experiences

  # validates :name, presence: true
  # validates :home_location, presence: true
end
