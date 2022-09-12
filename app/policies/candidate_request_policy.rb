# frozen_string_literal: true

# Handle candidate requests
class CandidateRequestPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    @user.admin?
  end

  def new?
    @user.voter?
  end

  def create?
    @user.voter?
  end

  def approve?
    @user.admin?
  end

  def update?
    @user.admin?
  end
end
