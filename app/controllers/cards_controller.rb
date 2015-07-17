class CardsController < ApplicationController

  # shows a list of all cards
  def index
    @cards = Card.all
  end

  # creates an new instance of a card
  def new
    @card = Card.new
  end

  # method for creating a new card
  def create
    # card gets created with parameters of card details
    @card = Card.create(card_params)
    # if card is valid based on our criteria (validations)
    # then the card will be created and added to list of all cards
    # and user will be redirected to list of all cards
    if @card.valid?
      redirect_to cards_path
    # if card doesn't fit our criteria, then user will get an
    # error message
    else
      flash[:alert] = "There was an error with your submission"
  end

  private
  # what does this do
  def card_params
    params.require(:card).permit(:number,
                                 :expiration_month,
                                 :expiration_year)
  end
end
