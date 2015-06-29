class Bike   
  def self.distance_to user_long, user_lat, long, lat
    Haversine.distance(user_long, user_lat, long, lat).to_miles
  end

  def self.bike_w_distances user_long, user_lat
    bike_data = BikeAPI.stations
    #all_bikes = bike_data["stations"]["station"]
    bike_data.min_by(3){|bike| distance_to(user_long, user_lat, Float(bike.long), Float(bike.lat))}
  end

attr_reader :id, :name, :lat, :long, :bikes_available, :empty_docks
  def initialize api_data
    @id = Float(api_data.fetch 'id')
    @name = api_data.fetch 'name'
    @lat = Float(api_data.fetch 'lat')
    @long = Float(api_data.fetch 'long')
    @bikes_available = Integer(api_data.fetch 'nbBikes')
    @empty_docks = Integer(api_data.fetch 'nbEmptyDocks')
  end
end
