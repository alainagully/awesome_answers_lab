class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #methods definned will be available to all controllers
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  #if we need methods to be available in views files we will need to add
  #'helper_method' and the first arguement is the method name as symbol

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

end
