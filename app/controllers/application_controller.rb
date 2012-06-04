class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  PER_PAGE = 15
end
