class Admin::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout 'admin'
  protect_from_forgery with: :exception
  protect_from_forgery unless: -> { request.format.json? }

  include SessionsHelper
end
