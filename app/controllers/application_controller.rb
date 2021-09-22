class ApplicationController < ActionController::Base

  before_action :show_footer

  def show_footer
    @show_footer = true
  end

end
