class BoardUsersController < ApplicationController
  def index
    # @users = Board.find(params[:board_id]).users
    @board_users = BoardUser.where(board_id: params[:board_id])
    @admin_board_user = @board_users.find_by(admin: true).user
  end

  def new
    @board_user = BoardUser.new
  end

  def create
    @board_user = BoardUser.new(board_user_params)
    if @board_user.save
      redirect_to board_path(@board_user.board)
    else
      render :new
    end
  end

  def destroy
    @board_user = BoardUser.find(params[:id])
    board = @board_user.board
    @board_user.destroy
    redirect_to user_boards_path(current_user)
  end

  private

  def board_user_params
    params.require(:board_user).permit(:user_id, :board_id, :admin)
  end
end
