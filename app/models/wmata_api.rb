require 'httparty'
require 'json'
require 'pry'

class WmataApi

  def train_station_info station_code
    @token = File.read "./token.txt"
    @station_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_code}", query: { api_key: "#{@token}" })
  end

  def sorted_3 list    
    sorted = list.sort_by {|hsh| hsh[:distance]}   
    sorted.first(3)    
  end

  def bus_w_distances user_long, user_lat
    @token = File.read "./token.txt"
    bus_info= HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?long=#{user_long}&lat=#{user_lat}&1000&api_key=#{@token}")
    all_buses = bus_info["Stops"]
    all_buses.min_by(3){|bus| distance_to(user_long, user_lat, bus["Lat"], bus["Lon"] )}
  end

  def bus_predictions list
    list.each do |station|
    bus_prediction = HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions/?StopID=#{station["StopID"]}", query: {api_key: "#{@token}" })
    station[:prediction] = bus_prediction["Predictions"]
    end
    list.to_json
  end

  def distance_to user_long, user_lat, long, lat
    Haversine.distance(user_long, user_lat, long, lat).to_miles
  end

  def trains_w_distances user_long, user_lat
    all_trains = Train.all
    all_trains.min_by(3){|train| distance_to(user_long, user_lat, train.longitude, train.latitude)}
  end

  def trains_live_data three_trains

    three_trains.map do |station|
      station.attribues.merge(next_train:  (train_station_info station["code"]))
    end.to_json
  end

  def bike_w_distances user_long, user_lat
    bike_data = HTTParty.get("http://www.capitalbikeshare.com/data/stations/bikeStations.xml", query: { api_key: "#{@token}" })
    all_bikes = bike_data["stations"]["station"]
    sorted = all_bikes.min_by(3){|bike| distance_to(user_long, user_lat, bike['long'].to_f, bike['lat'].to_f)}
    binding.pry
    sorted
  end
end




