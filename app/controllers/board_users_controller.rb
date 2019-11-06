class BoardUsersController < ApplicationController
  def index
    # @users = Board.find(params[:board_id]).users
    @board_users = BoardUser.where(board_id: params[:board_id])
  end

  def new
    @board_user = BoardUser.new
  end

  def create
    @board_user = BoardUuser.new(board_user.params)
    if board_user.save
      redirect_to board_users_path
    else
      render :new
    end
  end

  def destroy
    @board_user = BoardUser.find(params[:id])
    board = @board_user.board
    @board_user.destroy
    redirect_to board_board_users_path(board)
  end

  private

  def board_user_params
    params.require(:board_user).permit(:user_id, :board_id)
  end
end
