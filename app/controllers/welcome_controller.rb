# frozen_string_literal: true

# Class for welcome Screen
class WelcomeController < ApplicationController
  def welcome_page
    # Do noting here
  end

  def dashboard_page
    redirect_to new_user_session_path unless user_signed_in?
  end
end
