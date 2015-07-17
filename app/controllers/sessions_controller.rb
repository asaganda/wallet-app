class SessionsController < ApplicationController

  # this creates a session
  def create
    # this finds the user by their email which 
    # we have in users database from when they signed 
    # up as a new user
    user = User.find_by_email(params[:email])
    if user
      # this flashes a welcome message to the user once
      # they're logged into their session successfully
      # and redirects them to the users path
      if user.password == params[:password]
        session[:user_id] = user.id
        flash[:welcome] = "Welcome Back"
        redirect_to users_path
      end
    # this flashes a error message when the password 
    # doesn't match, essentially wrong credentials and
    # then redirects them to the new session path
    else
      flash[:alert] = "Invalid Credentials"
      redirect_to new_session_path
    end
  end
  # this destroys the current session
  def destroy
    user = User.find params[:id]
    user.destroy
  end

end