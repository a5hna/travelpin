class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def user_board
    @user = current_user
    @boards = Board.where(user: @user)
  end
end
