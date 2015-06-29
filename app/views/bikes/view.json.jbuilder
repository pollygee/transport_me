json.bikes @closest_3_stations do |station|
  json.name station.name
  json.lat station.lat.to_s
  json.long station.long.to_s
  json.bikes_available station.bikes_available.to_s
  json.empty_docks station.empty_docks.to_s
end