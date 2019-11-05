class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    @board_users = @board.users
    @experiences = @board.experiences


    @experience = Experience.new
    @experience.board_id = @board
    @experience.user_id = current_user

  end

  def new
    @board = Board.new
  end

  def create
    @board = Board
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
