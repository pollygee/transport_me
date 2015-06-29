require 'httparty'

class BikeAPI
  include HTTParty
  base_uri "http://www.capitalbikeshare.com/data/"

  def self.stations
  response = get "/stations/bikeStations.xml"
  response["stations"]["station"].map { |s| Bike.new(s) }
  end
end