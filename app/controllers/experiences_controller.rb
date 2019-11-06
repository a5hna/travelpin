require 'open-uri'
require 'json'

class ExperiencesController < ApplicationController

  def create
   @experience = Experience.new(experience_params)
   @experience.board_id = params[:board_id]
   board_location = [@experience.board.latitude, @experience.board.longitude]
   query = @experience.title
   places_endpoint = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{query}&inputtype=textquery&language=#{session[:language]}&fields=place_id,name,photos,formatted_address&locationbias=circle:100000@#{board_location[0]},#{board_location[1]}&key=#{ENV['GOOGLE_MAPS_KEY']}"
   api_response = open(places_endpoint).read
   results = JSON.parse(api_response)
   @count = results["candidates"].length
   @list = results["candidates"]
   photoref = results["candidates"][0]["photos"][0]["photo_reference"]
   photos_endpoint = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{photoref}&key=#{ENV['GOOGLE_MAPS_KEY']}"
   @photo = photos_endpoint
  end

  def edit
  end

  def update
  end

  private

  def experience_params
    params.require(:experience).permit(:title, :description)
  end
end
