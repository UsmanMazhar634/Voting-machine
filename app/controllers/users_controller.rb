# frozen_string_literal: true

# Controller for user
class UsersController < ApplicationController
  # Display all Users
  def index
    authorize User
    @users = User.all
  end

  # Show profile of a User.
  def show
    authorize User
  end
end
