class UsersController < ApplicationController
  # this creates an instance of a new user but
  # doesn't save it
  def new
    @user = User.new
  end

  def index
    # lists users, redirects someone to a new session
    # if they're not signed in unless they're a current user
    redirect_to new_session_path unless current_user
    @users = User.all
  end

  def create
    # creates and saves a user, saves their info via user params
    @user = User.create user_params
    # if the user is valid, they get a flash message and
    # get redirected to the users path
    if @user.valid?
      flash[:notice] = "Thanks for signing up"
      redirect_to users_path
    # if the user is invalid, they also get a flash message
    # and get a new form which i believe is the new sign-up
    else
      flash[:alert] = "There was a problem."
      render :new
    end
  end

  # what is this block of code again?
  private

  def user_params
    params.require(:user).permit(:fname,
                                 :lname, 
                                 :password,
                                 :email,
                                 :password_confirmation)
  end

end