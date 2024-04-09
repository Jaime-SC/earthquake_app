class Earthquake < ApplicationRecord
    has_many :comments, foreign_key: 'feature_id', primary_key: 'id'
  
    validates :mag, :place, :time, :url, :mag_type, :title, :longitude, :latitude, presence: true
    validates :mag, inclusion: { in: -1.0..10.0 }
    validates :latitude, inclusion: { in: -90.0..90.0 }
    validates :longitude, inclusion: { in: -180.0..180.0 }
  
    def as_json(options = {})
      {
        id: id,
        type: 'feature',
        attributes: {
          external_id: id,
          magnitude: mag,
          place: place,
          time: time,
          tsunami: tsunami,
          mag_type: mag_type,
          title: title,
          coordinates: {
            longitude: longitude,
            latitude: latitude
          }
        },
        links: {
          external_url: url
        }
      }
    end
  end
