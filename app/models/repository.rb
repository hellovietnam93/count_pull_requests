class Repository < ApplicationRecord
  belongs_to :user

  has_many :query_conditions, dependent: :destroy
end
