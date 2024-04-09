module Api
  class CommentsController < ApplicationController
    def create
      feature_id = params[:feature_id]
      body = params.dig(:comment, :body)

      if body.blank?
        render json: { error: 'Comment body cannot be blank' }, status: :unprocessable_entity
        return
      end

      earthquake = Earthquake.find_by(id: feature_id)

      unless earthquake
        render json: { error: 'Earthquake not found' }, status: :not_found
        return
      end

      comment = Comment.new(body: body, feature_id: feature_id)

      if comment.save
        render json: { data: { id: comment.id, feature_id: feature_id, body: body } }, status: :created
      else
        render json: { error: comment.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    end
  end
end