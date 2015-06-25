class BikesController < ApplicationController
  def view
    user_lat = params[:lat].to_f
    user_long = params[:long].to_f
    bike = WmataApi.new
    #@bikes = Bike.all
    @closest_3_stations = bike.bike_w_distances user_long, user_lat
  end
end