class BikesController < ApplicationController
  def view
    user_lat = Float(params[:lat])
    user_long = Float(params[:long])
    bike = WmataApi.new
    #@bikes = Bike.all
    @closest_3_stations = bike.bike_w_distances user_long, user_lat
  end
end