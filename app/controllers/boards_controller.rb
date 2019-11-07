require 'open-uri'
require 'nokogiri'

class BoardsController < ApplicationController
  before_action :set_board, except: [:new]

  def show
    session[:language] = 'en'
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

    url = "http://api.openweathermap.org/data/2.5/weather?lat=#{@board.latitude}&lon=#{@board.longitude}&APPID=#{ENV['OPENWEATHER']}"
    file = open(url).read
    @data = JSON.parse(file)
  end

  def new
    @board = Board.new
    # country_url = "https://www.lonelyplanet.com/#{board_params[:country]}"
    # city_url = "https://www.lonelyplanet.com/#{board_params[:country]}/#{board_params[:city]}"


    # lonelyplanet_html = open(city_url).read
    # lonelyplanet_data = Nokogiri::HTML(lonelyplanet_html)
    # caption = lonelyplanet_data.search('.featured p').text.strip
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
