class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # TODO: move this out
  class User
    def initialize
    end
    def is_admin?
      true
    end
  end
  
  def current_user
    User.new()
  end
end
