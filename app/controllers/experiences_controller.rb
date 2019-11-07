require 'open-uri'
require 'json'

class ExperiencesController < ApplicationController

  def create
   @experience = Experience.new(experience_params)
   @experience.board_id = params[:board_id]
   board_location = [@experience.board.latitude, @experience.board.longitude]
   query = @experience.title
   places_endpoint = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{board_location[0]},#{board_location[1]}&radius=50000&keyword=#{query}&key=#{ENV['GOOGLE_MAPS_KEY']}&language=#{session[:language]}"
   api_response = open(places_endpoint).read
   results = JSON.parse(api_response)
   @list = results["results"][0..4]
   photo_refs = @list.map {|each| each["photos"][0]["photo_reference"]}
   @photos = photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"}
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
