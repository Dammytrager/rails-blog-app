class ApplicationController < ActionController::Base

  before_action :show_footer

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def show_footer
    @show_footer = false
  end

end
