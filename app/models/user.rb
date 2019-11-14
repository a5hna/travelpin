class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  acts_as_voter
  # has_many :connections, dependent: :destroy
  has_many :board_users, dependent: :destroy
  has_many :boards, through: :board_users
  has_many :experiences
  has_many :connections, class_name: 'Connection', foreign_key: 'user_two'
  has_many :connections, class_name: 'Connection', foreign_key: 'user_one'

  mount_uploader :avatar, PhotoUploader

  # validates :name, presence: true
  # validates :home_location, presence: true
end
