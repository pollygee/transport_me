class TrainsController < ApplicationController
  def view
    user_lat = Float(params[:lat])
    user_long = Float(params[:long])
    train = TransitApi.new
    list = train.trains_w_distances user_long, user_lat
    @final_data = train.trains_live_data list, user_long, user_lat
    #@list[:next_train] => train_station_info station["code"])
  end

end


