class User < ActiveRecord::Base
  # firstname, lastname, and email all must be present 
  # for a user to be valid
  validates_presence_of :fname, :lname, :email, :password
  # tests that the email provided by user is unique and 
  # that the database doesn't have that email already 
  # (no account previously made)
  validates_uniqueness_of :email
  # tests to confirm the password entered
  validates_confirmation_of :password
  #we want the user to input their phone number with dashes
  validates_format_of :phone, with: /\d{3}-\d{3}-\d{4}/
  # the account balance must be greater than 0.00
  validates_numericality_of :balance, { greater_than_or_equal_to: 0}

  # many to many relationship
  has_many :user_cards
  has_many :card, through: :user_cards

  before_destroy :destroy_solely_owned_cards

  # what does this entire code block do?
  def destroy_solely_owned_cards
    all_my_cards = self.cards
    owned_cards = all_my_cards.select do |card|
                    cards.users.length == 1
                  end
    owned_cards.each &:destroy!
  end

  # method full_name is concatenating fname + lname together to produce
  # the user's full name and this is being called in the users < index.html.erb
  def full_name
    fname + ' ' + lname
  end
end
