class SessionsController < ApplicationController
  # we have this because a new user doesn't have a session until they log in
  def new
  end

  # this creates a session
  def create
    # setting the authentication to user and then if the user's 
    # password attempting to login and the user's password stored 
    # match, then a new session is created. If not, no bueno
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      flash[:welcome] = "Logged In!"
      redirect_to users_path
    else
      flash[:alert] = "Invalid Credentials"
      redirect_to new_session_path
  end

  # this destroys the current session
  # don't know why we changed this from what it was, ASK!
  # message appears when user is logged out and then
  # redirects them to the root page
  def destroy
    session.clear
    flash[:notice] = "Logged Out"
    redirect_to root_path
  end

end