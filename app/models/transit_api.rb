require 'httparty'
require 'json'
require 'pry'

class TransitApi

  def train_station_info station_code
    @token = File.read "./token.txt"
    @station_info = HTTParty.get("https://api.wmata.com/StationPrediction.svc/json/GetPrediction/#{station_code}", query: { api_key: "#{@token}" })
    @station_info.first[1]
  end

  def sorted_3 list    
    sorted = list.sort_by {|hsh| hsh[:distance]}   
    sorted.first(3)    
  end

  def bus_w_distances user_long, user_lat
    @token = File.read "./token.txt"
    bus_info= HTTParty.get("https://api.wmata.com/Bus.svc/json/jStops?long=#{user_long}&lat=#{user_lat}&1000&api_key=#{@token}")
    all_buses = bus_info["Stops"]
    t = all_buses.min_by(3){|bus| distance_to(user_long, user_lat, bus["Lat"], bus["Lon"] )}
    #t= t[0]
    t.each do |bus|
        bus[:distance] = distance_to(user_long, user_lat, bus["Lon"], bus["Lat"])
  end
  t
  end

  def bus_predictions list
    fail
    list.each do |station|
    bus_prediction = HTTParty.get("https://api.wmata.com/NextBusService.svc/json/jPredictions}", query: { StopID: "#{station["StopID"]}", api_key: "#{@token}" })
    station[:prediction] = bus_prediction["Predictions"]
    end
    list
  end

  def distance_to user_long, user_lat, long, lat
    Haversine.distance(user_long, user_lat, long, lat).to_miles
  end

  def trains_w_distances user_long, user_lat
    all_trains = Train.all
    all_trains.min_by(3){|train| distance_to(user_long, user_lat, train.longitude, train.latitude)}
  end

  def trains_live_data three_trains, user_long, user_lat
    three_trains.map do |station|
      { name: station.name,
        code: station.code,
        distance: distance_to(user_long, user_lat, station.longitude, station.latitude),
        next_train:  (train_station_info station["code"]).map do |t|
              {
                line:      t["Line"],
                min:      t["Min"],
                cars:      t["Car"],
                direction: t["Destination"],
              }
      end
      }
    end
  end

  def bike_w_distances user_long, user_lat
    bike_data = HTTParty.get("http://www.capitalbikeshare.com/data/stations/bikeStations.xml", query: { api_key: "#{@token}" })
    all_bikes = bike_data["stations"]["station"]
    sorted = all_bikes.min_by(3){|bike| distance_to(user_long, user_lat, bike['long'].to_f, bike['lat'].to_f)}
    sorted
  end
end




