# frozen_string_literal: true

# Controller for user
class UsersController < ApplicationController
  def index
    authorize User
    @users = User.all
  end

  def show
    authorize User
  end
end
