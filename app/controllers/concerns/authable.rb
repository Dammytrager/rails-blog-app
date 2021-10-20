module Authable
  extend ActiveSupport::Concern

  included do
    before_action :prevent_auth, only: [:new, :create]
  end

  def prevent_auth
    if logged_in?
      redirect_to current_user
    end
  end
end