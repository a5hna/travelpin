class BoardsController < ApplicationController
  before_action :set_board

  def show
    @board_users = @board.users
    @experiences = @board.experiences
    @experience = Experience.new
    @experience.board_id = @board
    @experience.user_id = current_user
    @map_center = [@board.latitude.to_f, @board.longitude.to_f]
    @markers = []
    @experiences.each do |e|
      @markers << [e.latitude.to_f, e.longitude.to_f]
    end

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

  private

  def set_board
    @board = Board.find(params[:id])
  end
end
