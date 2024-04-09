class Comment < ApplicationRecord
    belongs_to :earthquake, foreign_key: 'feature_id', primary_key: 'id'
  
    validates :body, presence: true
  end
