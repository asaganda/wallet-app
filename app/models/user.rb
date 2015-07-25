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

  # before we destroy the user and their info/records/cards,
  # we destroy their cards associated with the user
  before_destroy :destroy_solely_owned_cards

  # we want the password hash to be generated before we create the new user
  before_create :encrypt_password

  # this line is what makes password in the argument just below within encrypt_password method work.
  # this line ensures that we can store password on our user instance, just long
  # enough to generate the password hash
  attr_accessor :password

  # encrypts password
  def encrypt_password
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end

  # this authenticates all users
  def self.authenticate(email, password)
    # finds the user based on email, if found user, then password authentication is done just below
    user = User.where(email: email).first

    # password authentication done here
    # when the user's password when they are trying to login and the user's password when they 
    # first created their password are matched exactly, then access is granted
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end


  # deletes any cards for which the destroyed user was the sole user
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
