# frozen_string_literal: true

# Handle Votes
class VotePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.admin?
  end

  def new?
    user.voter? || user.candidate? || user.admin?
  end

  def create?
    user.voter? || user.candidate? || user.admin?
  end
end
