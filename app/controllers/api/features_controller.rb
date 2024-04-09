module Api
  class FeaturesController < ApplicationController
    def index
      mag_type_filters = params.dig(:filters, :mag_type)&.split(',')
      per_page = params[:per_page]&.to_i || 10
      page = params[:page]&.to_i || 1

      earthquakes = Earthquake.all

      if mag_type_filters
        earthquakes = earthquakes.where(mag_type: mag_type_filters)
      end

      total_count = earthquakes.count
      earthquakes = earthquakes.limit(per_page).offset((page - 1) * per_page)

      serialized_data = earthquakes.map do |earthquake|
        {
          id: earthquake.id,
          type: 'feature',
          attributes: {
            external_id: earthquake.id,
            magnitude: earthquake.mag,
            place: earthquake.place,
            time: earthquake.time,
            tsunami: earthquake.tsunami,
            mag_type: earthquake.mag_type,
            title: earthquake.title,
            coordinates: {
              longitude: earthquake.longitude,
              latitude: earthquake.latitude
            }
          },
          links: {
            external_url: earthquake.url
          }
        }
      end

      render json: {
        data: serialized_data,
        pagination: {
          current_page: page,
          total: total_count,
          per_page: per_page
        }
      }
    end
  end
end