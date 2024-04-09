module Api
  class EarthquakesController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      per_page = params[:per_page]&.to_i || 10
      page = params[:page]&.to_i || 1
      mag_types = params[:filters]&.dig(:mag_type)&.split(',')

      earthquakes = Earthquake.all
      earthquakes = earthquakes.where(mag_type: mag_types) if mag_types
      earthquakes = earthquakes.page(page).per(per_page)

      render json: earthquakes, meta: pagination_dict(earthquakes)
    end

    def create_comment
      earthquake = Earthquake.find(params[:feature_id])
      comment = earthquake.comments.new(body: params[:body])

      if comment.save
        render json: { status: 'success', comment: comment }
      else
        render json: { status: 'error', message: comment.errors.full_messages.join(', ') }
      end
    end

    private

    def pagination_dict(collection)
      {
        current_page: collection.current_page,
        total: collection.total_count,
        per_page: collection.limit_value
      }
    end
  end
end