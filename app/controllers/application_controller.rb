# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_peremitters, if: :devise_controller?
  def configure_permitted_peremitters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name cnic image constituency])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fist_name last_name image])
    devise_parameter_sanitizer.permit(:become_candidate, keys: %i[party])
  end
end
