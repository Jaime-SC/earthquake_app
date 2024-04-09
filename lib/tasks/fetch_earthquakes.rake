require 'httparty'

namespace :fetch do
  desc "Fetch earthquake data from USGS"
  task earthquakes: :environment do
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    
    response = HTTParty.get(url)
    data = JSON.parse(response.body)

    data['features'].each do |feature|
      id = feature['id']
      mag = feature['properties']['mag']
      place = feature['properties']['place']
      time = Time.at(feature['properties']['time'] / 1000).to_s
      url = feature['properties']['url']
      tsunami = feature['properties']['tsunami']
      mag_type = feature['properties']['magType']
      title = feature['properties']['title']
      longitude = feature['geometry']['coordinates'][0]
      latitude = feature['geometry']['coordinates'][1]

      next if [title, url, place, mag_type, longitude, latitude].any?(&:nil?)
      next if mag < -1.0 || mag > 10.0
      next if latitude < -90.0 || latitude > 90.0
      next if longitude < -180.0 || longitude > 180.0

      earthquake = Earthquake.find_or_initialize_by(id: id)
      earthquake.update(
        mag: mag,
        place: place,
        time: time,
        url: url,
        tsunami: tsunami,
        mag_type: mag_type,
        title: title,
        longitude: longitude,
        latitude: latitude
      )
    end
  end
end
