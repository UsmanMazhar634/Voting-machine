# frozen_string_literal: true

# Manage User Policies
class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    @user.candidate?
  end

  def show?
    @user.voter? || @user.candidate?
  end
end
