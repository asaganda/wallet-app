# helper is a module that we can use to define any helpers that we want to be available to our views
module ApplicationHelper
  # defines current user for the session so we
  # can use the method elsewhere
  def current_user
    if session[:user_id]
      current_user = User.find(session[:user_id])
    end
  end
end