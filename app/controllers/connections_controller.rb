class ConnectionsController < ApplicationController
  def index
    if params[:board_id]
      @board = Board.find(params[:board_id])
      board_users = @board.users
    end
    @connections = current_user.connections
    @friends = friends(@connections).filter { |friend| !board_users.include?(friend) }
  end

  def new
    @connection = Connection.new
  end

  def create
    @connection = Connection.new(connection_params)
    if connection.save
      redirect_to connections_path
    else
      render :new
    end
  end

  def destroy
    @connection = Connection.find(params[:id])
    @connection.destroy
  end

  private

  def connection_params
    params.require(:connection).permit(:user_one, :user_two)
  end

  def friends(connections)
    connections.map do |connection|
      if connection.user_one == current_user
        connection.user_two
      else
        connection.user_one
      end
    end
  end
end
