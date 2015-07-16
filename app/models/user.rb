class User < ActiveRecord::Base
  # firstname, lastname, and email all must be present 
  # for a user to be valid
  validates_presence_of :fname, :lname, :email
  # tests that the email provided by user is unique and 
  # that the database doesn't have that email already 
  # (no account previously made)
  validates_uniqueness_of :email
  #we want the user to input their phone number with dashes
  validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/
  # the account balance must be greater than 0.00
  validates_numerically_of :balance, { greater_than: 0}

  # many to many relationship
  has_many :user_cards
  has_many :card, through: :user_cards
end
