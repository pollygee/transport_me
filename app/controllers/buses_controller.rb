class BusesController < ApplicationController
  def view
    user_lat = Float(params[:lat])
    user_long = Float(params[:long])
    bus = TransitApi.new
    closest_3_stations = bus.bus_w_distances user_long, user_lat
    @final_data = bus.bus_predictions closest_3_stations
  end
end