# frozen_string_literal: true

# Main Application Controller
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :configure_permitted_peremitters, if: :devise_controller?

  before_action :authenticate_user!, unless: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def configure_permitted_peremitters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name cnic image constituency])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fist_name last_name image])
  end

  private

  def user_not_authorized
    flash[:alert] = t('application.not_authorized')
    redirect_back(fallback_location: root_path)
  end

  def record_not_found
    flash[:alert] = t('application.record_dont_exist')
    redirect_back(fallback_location: root_path)
  end
end
