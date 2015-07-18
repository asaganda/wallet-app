class Card < ActiveRecord::Base

  # \A represents the beginning of a string,[345] in bracket acts as big OR statement.. 3 or 4 or 5
  # \d represents the number of digits (in our case, the length),{11,} is 11 and above
  # \Z represents the end of the string
  # checkout rubular.com for reference
  validates_format_of :number, with: /\A[345]\d{11,}/

  # expiration month can be between month 1 and month 12
  validates :expiration_month, inclusion: {in: (1..12)}

  # expiration year can be between year 2015 and 2115
  validates :expiration_year, inclusion: {in: (2015..2115)}

  # this saves the card type before the card is saved into database
  before_save :set_card_type

  validates :users, presence: true

  
  def set_card_type
    # use self. for activerecord instance
    first_num = self.number[0]

    # since we're setting type for this card use self.
      # we have to use self.type otherwitse it will set the type as a variable
    # we can't use just 'type' because thats a special name in rails that is reserved
    # we write self because we're telling the model that card_type already 
    # exists..which is the field in the model (column)
    self.card_type = case first_num

    # first_num is in a string..so has to be '3'
    when '3'
      'American Express'
    when '4'
      'Visa'
    when '5'
      'MasterCard'
    end
  end
  # many to many relationship
  has_many :user_cards
  has_many :users, through: :user_cards
end
