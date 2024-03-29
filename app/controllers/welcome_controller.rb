# frozen_string_literal: true

# Class for welcome Screen
class WelcomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
  end
end
