class ConnectionsController < ApplicationController
  def index
    if params[:board_id]
      @board = Board.find(params[:board_id])
      @board_users = @board.users
    end
    @connections = current_user.connections
    if @board_users
    @friends = friends(@connections).filter { |friend| !@board_users.include?(friend) }
    else
    @friends = friends(@connections)
    end
    @users = User.all
  end

  def new
    @connection = Connection.new
  end

  def create
    @connection = Connection.new(user_one: User.find(connection_params[:user_one].to_i), user_two: User.find(connection_params[:user_two].to_i))
    if @connection.save
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
