require 'open-uri'
require 'json'
require 'pry-byebug'
class ExperiencesController < ApplicationController
before_action :pundit_sucks


  def nearby_search_api(query, coords)
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

  def find_place_api(query, coords)
    endpoint = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?"
    search_query = "input=#{query}&inputtype=textquery"
    fields = "&fields=place_id,name,formatted_address,photos,geometry"
    location = "&locationbias=point:#{coords[0]},#{coords[1]}"
    key = "&key=#{ENV['GOOGLE_MAPS_KEY']}"
    language = "&language=en"
    api_call = endpoint+search_query+fields+location+language+key
    uri = open(api_call).read
    results = JSON.parse(uri)
    return results["candidates"]
  end

  def details_api(place_id)
   key = "&key=#{ENV['GOOGLE_MAPS_KEY']}"
   details_endpoint = "https://maps.googleapis.com/maps/api/place/details/json?place_id=#{place_id}&key=#{ENV['GOOGLE_MAPS_KEY']}"
   query_fields = "&fields=name,geometry,formatted_address,photos,rating,opening_hours,website,url,price_level,international_phone_number"
   api_call = details_endpoint+query_fields
   uri = open(api_call).read
   results = JSON.parse(uri)["result"]
   byebug
   details = {}
   details[:user_id] = current_user.id
   details[:board_id] = @experience[:board_id]
   details[:category_id] = @experience[:category_id]
   details[:title] = @experience[:title]
   details[:description] = @experience[:description]
   details[:latitude] = results["geometry"]["location"]["lat"] || nil
   details[:longitude] = results["geometry"]["location"]["lng"] || nil
   details[:address] = results["formatted_address"] || nil
   details[:opening_hours] = results["opening_hours"] ? results["opening_hours"]["weekday_text"] : nil
   details[:phone_number] = results["international_phone_number"] || nil
   details[:rating] = results["rating"] || nil
   details[:google_url] = results["url"] || nil
   details[:website] = results["website"] || nil
   details[:price_level] = results["price_level"] || nil
   photo_refs = results["photos"].map {|each| each["photo_reference"]}[0..4] if results["photos"]
   details[:photos] = photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"} if photo_refs
   return details
  end

   helper_method :details_api


  def new
   @board = Board.find(params[:board_id])
   @experience = Experience.new(experience_params)
   city = params[:other][:level] == 'city'
   query = URI.escape(@experience.title)
   @coords = [@board.latitude, @board.longitude]
   @map_bounds = [[@board.ne_lat, @board.ne_lng],[@board.sw_lat, @board.sw_lng]]
   @list = city ? nearby_search_api(query, @coords) : find_place_api(query, @coords)
   @places = @list.map do |each|
     { title:  @experience.title,
       category_id: @experience.category_id,
       coords: [each["geometry"]["location"]["lat"].to_f, each["geometry"]["location"]["lng"].to_f],
       photos: (each["photos"][0]["photo_reference"] if each["photos"]) }
   end
   @markers = @list.map {|each| [each["geometry"]["location"]["lat"].to_f, each["geometry"]["location"]["lng"].to_f] }
   @photo_refs = @list.map do |each|
     if each["photos"]
       each["photos"][0]["photo_reference"]
     end
   end
   @photo_refs.delete(nil)
   @photos = @photo_refs.map {|pic| "https://maps.googleapis.com/maps/api/place/photo?maxwidth=1600&photoreference=#{pic}&key=#{ENV['GOOGLE_MAPS_KEY']}"}
  end

  def create
    exp = Experience.new(experience_params)
    exp.user = current_user
    exp.board_id = params[:board_id]
    exp.save
    if exp.save!
    redirect_to board_path(exp.board)
    else
      raise
    end
  end

  def index
    category_id = params["experience"]["category_id"]
    @category_name = Category.find(category_id).name.capitalize
    @board = Board.find(params["board_id"])
    @experiences = @board.experiences.where(category_id: category_id)
  end


  def edit
  end

  def update
  end

  def upvote

    @experience = Experience.find(params[:id])
    old_count = @experience.votes_for.count

    @experience.vote_by :voter => current_user
    new_count = @experience.votes_for.count

    @voted = old_count != new_count

    respond_to do |format|
        # format.html { redirect_to restaurant_path(@restaurant) }
        format.js
      end

  end

  private

  def pundit_sucks
    authorize current_user
  end

  def experience_params
    params.require(:experience).permit(:longitude, :latitude, :title, :description, :photo, :board_id, :user_id, :category_id, :address, :rating, :opening_hours, :price_level, :phone_number, :website, :google_url)
  end
end
