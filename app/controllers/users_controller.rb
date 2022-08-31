# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def display_voters
    @candidate = User.find(params[:id])
    @users = User.all
  end
end
