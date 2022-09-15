# frozen_string_literal: true

# Controller for user
class UsersController < ApplicationController
  before_action :set_user_policy, only: %i[index show]

  def index
    @users = User.all
  end

  def show
    # Showing Profile
  end

  private

  def set_user_policy
    authorize User
  end
end
