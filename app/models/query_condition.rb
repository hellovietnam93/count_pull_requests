class QueryCondition < ApplicationRecord
  ATTRIBUTE_PARAMS = %i(content user_id repository_id).freeze

  belongs_to :repository
  belongs_to :user

  has_many :pull_requests, dependent: :destroy
end
