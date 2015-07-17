class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # includes all the methods defined in that module 
  # as instance methods for this class
  include ApplicationHelper
end

