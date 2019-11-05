class ConnectionsController < ApplicationController
  def index
    @connections = Connection.all
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
end
