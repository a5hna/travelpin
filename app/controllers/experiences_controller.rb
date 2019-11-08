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
   key = "&key=#{ENV['GOOGLE_MAPS_KEY']}"
   details_endpoint = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAPS_KEY']}"
   query_fields = "&fields=name,geometry,formatted_address,photos,rating,opening_hours,website,url,price_level,international_phone_number"
   language = "&language=#{session["language"]}"
   uri = open(details_endpoint+query_fields+language).read
   results = JSON.parse(uri)["result"]
   model = {}
   model[:user_id] = current_user.id
   model[:title] = @experience[:title]
   model[:description] = @experience[:description]
   model[:board_id] = @experience[:board_id]
   model[:latitude] = results["geometry"]["location"]["lat"] || nil
   model[:longitude] = results["geometry"]["location"]["lng"] || nil
   model[:address] = results["formatted_address"] || nil
   model[:opening_hours] = results["opening_hours"] ? results["opening_hours"]["weekday_text"] : nil
   model[:phone_number] = results["international_phone_number"] || nil
   model[:rating] = results["rating"] || nil
   model[:google_url] = results["url"] || nil
   model[:website] = results["website"] || nil
   model[:price_level] = results["price_level"] || nil
   photo_refs = results["photos"].map {|each| each["photo_reference"]}[0..4] if results["photos"]
   model[:photos] = photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"} if photo_refs
   return model
  end

   helper_method :details_api


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
    exp = Experience.new()
    exp.user_id = params[:experience][:user_id]
    exp.title = params[:experience][:title]
    exp.description = params[:experience][:description]
    exp.address = params[:experience][:address]
    exp.longitude = params[:experience][:longitude]
    exp.latitude = params[:experience][:latitude]
    exp.photo = params[:experience][:photo]
    exp.rating = params[:experience][:address]
    exp.opening_hours = params[:experience][:opening_hours]
    exp.price_level = params[:experience][:price_level]
    exp.phone_number = params[:experience][:phone_number]
    exp.website = params[:experience][:website]
    exp.google_url = params[:experience][:google_url]
    exp.board_id = params[:experience][:board_id]
    exp.category_id = 1
    exp.save
    redirect_to board_path(exp.board)
  end


  def edit
  end

  def update
  end

  private

  def experience_params
    params.require(:experience).permit(:longitude, :latitude, :title, :description, :photo, :board_id, :user_id, :category_id, :address, :rating, :opening_hours, :price_level, :phone_number, :website, :google_url)
  end
end
