class User < ActiveRecord::Base
  # many to many relationship
  has_many :user_cards
  has_many :card, through: :user_cards
end
