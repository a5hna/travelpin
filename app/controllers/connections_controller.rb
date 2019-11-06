class ConnectionsController < ApplicationController
  def index
    @connections = current_user.connections
    @friends = friends(@connections)
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
