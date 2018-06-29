class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :repositories, dependent: :destroy
  has_many :query_conditions, dependent: :destroy
end
