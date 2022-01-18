class ApplicationController < ActionController::Base
  before_action :authenticate_admin!

  protect_from_forgery with: :exception
end
