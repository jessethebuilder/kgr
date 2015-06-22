class ApplicationController < ActionController::Base
  include AuthHelper

  protect_from_forgery with: :exception

end
