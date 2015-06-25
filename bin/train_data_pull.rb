require 'httparty'

data = HTTParty.get("https://api.wmata.com/Rail.svc/json/jStations", query: { api_key: "d311c928b8364eff80d7462f7938b2b1" })
all_stations = data["Stations"]

all_stations.each do |station|
  Train.create! code: station["Code"], name: station["Name"], address: station["Address"], latitude: station["Lat"],
  longitude: station["Lon"]
end