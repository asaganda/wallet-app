# what does this do again?
module ApplicationHelper
  # defines current user for the session so we
  # can use the method elsewhere
  def current_user
    if session[:user_id]
      current_user = User.find(session[:user_id])
    end
  end
end