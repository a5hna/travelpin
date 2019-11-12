require 'open-uri'
require 'nokogiri'

class BoardsController < ApplicationController
  before_action :set_board, except: [:new, :create]

  def show
    category_icons = ['🍺', '🧗‍♀️', '👯‍♀️', '🏀', '🗼', '🎁', '⛩', '📺']
    session[:language] = 'en'
    @coords = [@board.latitude.to_f, @board.longitude.to_f]
    @board_users = @board.users
    if params[:experience]
      @experiences = @board.experiences.where(category_id: params[:experience][:category_id])
    else
      @experiences = @board.experiences
    end
    @experience = Experience.new
    @experience.board_id = @board
    @experience.user_id = current_user
    @map_center = [@board.latitude.to_f, @board.longitude.to_f]
    @markers = []
    @places = @experiences.map do |each|
      {title: each.title,
       description: each.description,
       coords: [each.latitude.to_f, each.longitude.to_f],
       category_id: each.category_id,
       id: each.id}
    end
    @experiences.each do |e|
      @markers << [e.latitude.to_f, e.longitude.to_f]
    end

    url = "https://api.openweathermap.org/data/2.5/weather?lat=#{@board.latitude}&lon=#{@board.longitude}&APPID=#{ENV['OPENWEATHER']}"
    file = open(url).read
    @data = JSON.parse(file)

    @country_code = @data["sys"]["country"]
    @city = @data["name"]

    @currency_code = CountryCode.where(country_code: @country_code).first.currency_code
    @country = CountryCode.where(country_code: @country_code).first.country
    country_url = "https://www.lonelyplanet.com/#{@country}"

    if @board.description == nil
    lonelyplanet_html = open(country_url).read
    lonelyplanet_data = Nokogiri::HTML(lonelyplanet_html)
    @caption = lonelyplanet_data.search('.featured p').text.strip
    @board.description = @caption
    @board.save
    end

    curr_conv_url ="https://free.currconv.com/api/v7/convert?q=GBP_#{@currency_code}&compact=ultra&apiKey=#{ENV['CURR_CONV_KEY']}"
    curr_conv_file = open(curr_conv_url).read
    @conversion = JSON.parse(curr_conv_file)
  end

  def new
    @board = Board.new

  end

  def create
    @board = Board.new
    @board.place = params[:board]["place"]
    @board.title = params[:board]["title"]
    if @board.valid?
    @board.save
    @board_user = BoardUser.create(board_id: @board.id, user_id: current_user.id, admin: true)
    redirect_to board_path(@board)
    else
    render "new"
    end
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
