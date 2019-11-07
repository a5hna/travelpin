require 'open-uri'
require 'json'

class ExperiencesController < ApplicationController

  def new
   @experience = Experience.new(experience_params)
   @experience.board_id = params[:board_id]
   @coords = [@experience.board.latitude, @experience.board.longitude]
   query = @experience.title
   places_endpoint = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{@coords[0]},#{@coords[1]}&radius=50000&keyword=#{query}&key=#{ENV['GOOGLE_MAPS_KEY']}&language=#{session[:language]}"
   api_response = open(places_endpoint).read
   results = JSON.parse(api_response)
   @list = results["results"][0..4]
   @markers = @list.map {|each| [each["geometry"]["location"]["lat"].to_f, each["geometry"]["location"]["lng"].to_f] }
   photo_refs = @list.map {|each| each["photos"][0]["photo_reference"]}
   @photos = photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"}
  end

  def create
    @experience = Experience.new
    @experience.title = params["title"]
    @experience.description = params["description"]
    place_id = params["place_id"]
    details_endpoint = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAPS_KEY']}"
    query_fields = "&fields=name,geometry,formatted_address,photos,rating,opening_hours,website,url,price_level,international_phone_number"
    language = "&language=#{session["language"]}"
    uri = open(details_endpoint+query_fields+language).read
    results = JSON.parse(uri)["result"]
    @experience.name = results["name"]
    @experience.latitude =
    @experience.longitude =
    @experience.photo =

    byebug

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
