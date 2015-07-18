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
      # this logs the new user in automatically after they have signed up
      session[:user_id] = @user.id
      redirect_to users_path
    # if the user is invalid, they also get a flash message
    # and get a new form which i believe is the new sign-up
    else
      flash[:alert] = "There was a problem."
      render :new
    end
  end

  # shows the user profile of whoever is logged in
  def show
    # this finds the current user
    @user = User.find params[:id]
  end

  # ability for user to edit their profile
  def edit
    # this finds the current user
    @user = User.find params[:id]
  end

  # ability for user to update their recent edit to their profile
  def update
    # this finds the current user
    @user = User.find params[:id]
    # just setting the variable 'p' to user_params
    p = user_params
    # if the user's password is blank, delete their password? ASK!
    if user_params[:password].blank?
      p.delete(:password)
      p.delete(:password_confirmation)
    end
    # this updates what the user changed?
    @user.update! p
    # flash message after they have updated info
    flash[:notice] = "Successful update"
    # redirects the user to their newly update profile?
    redirect_to user_path(@user)
  end

  # this method destroys the user's session or the user account as a whole?
  def destroy
    # finds the current user
    @user = User.find params[:id]
    # why do we have this?
    @user.destroy!
    session.clear
    # flash message shows when the user's session is over
    flash[:notice] = "Bye."
    redirect_to users_path
  end
  
  
  # any parameter submitted from a form needs 
  # to be listed in the .permit list
  # only i can see this information now that
  # it is private
  private

  def user_params
    params.require(:user).permit(:fname,
                                 :lname, 
                                 :password,
                                 :email,
                                 :phone,
                                 :password_confirmation)
  end

end