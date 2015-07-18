class CardsController < ApplicationController

  # shows a list of all cards
  def index
    # if a user is present(logged in), show the user's cards
    if params[:user_id].present?
      @user = User.find params[:user_id]
      @cards = @user.cards
    # if a user is not present(not logged in), just show all the cards
    else
      @cards = Card.all
  end

  # creates an new instance of a card
  def new
    @card = Card.new
  end

  # method for creating a new card
  def create
    # new instance of a card with parameters of card details
    @card = Card.new(card_params)
    # current user info gets associated with card?? ASK
    @card.users << current_user
    # if card is valid based on our criteria (validations)
    # then the card will be saved and added to list of all cards
    # and user will be redirected to list of all cards
    if @card.valid?
      @card.save!
      redirect_to cards_path
    # if card doesn't fit our criteria, then user will get an
    # error message
    else
      flash[:alert] = "There was an error with your submission"
    end
  end

  def show
    # shows a specific card
    @card = Card.find(params[:id])
  end

  private
  # what does this do
  def card_params
    params.require(:card).permit(:number,
                                 :expiration_month,
                                 :expiration_year)
  end
end
