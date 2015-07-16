class Card < ActiveRecord::Base
  # many to many relationship
  has_many :user_cards
  has_many :users, through: :user_cards
end
