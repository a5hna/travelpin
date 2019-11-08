require 'open-uri'
require 'json'

class ExperiencesController < ApplicationController



  def places_api(query, coords)
    key = "&key=#{ENV['GOOGLE_MAPS_KEY']}"
    location = "&location=#{coords[0]},#{coords[1]}"
    radius = "&radius=50000"
    language = "&language=#{session["language"]}"
    places_endpoint = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword="
    api_call = open(places_endpoint+query+location+radius+language+key).read
    results = JSON.parse(api_call)
    list = results["results"][0..4]
    return list
  end

  def details_api(place_id)
   details_endpoint = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAPS_KEY']}"
   query_fields = "&fields=name,geometry,formatted_address,photos,rating,opening_hours,website,url,price_level,international_phone_number"
   language = "&language=#{session["language"]}"
   uri = open(details_endpoint+query_fields+language).read
   results = JSON.parse(uri)["result"]
  end

  def new
    #choose panel
   @experience = Experience.new(experience_params)
   @experience.board_id = params[:board_id]
   @coords = [@experience.board.latitude, @experience.board.longitude]
   query = @experience.title
   @list = places_api(query, @coords)
   @markers = @list.map {|each| [each["geometry"]["location"]["lat"].to_f, each["geometry"]["location"]["lng"].to_f] }
   @photo_refs = @list.map do |each|
     if each["photos"]
       each["photos"][0]["photo_reference"]
     end
   end
   @photo_refs.delete(nil)
   @photos = @photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"}
  # confirm panel
  end

  def create
    @experience.latitude = results["geometry"]["location"]["lat"]
    @experience.longitude = results["geometry"]["location"]["lng"]
    @experience.address = results["formatted_address"]
    @experience.phone_number = results["international_phone_number"]
    @experience.rating = results["rating"]
    @experience.google_url = results["url"]
    @experience.website = results["website"]
    @experience.price_level = results["price_level"]
    photo_refs = results["photos"].map {|each| each["photo_reference"]}[0..4]
    @experience.photo = photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"}
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
