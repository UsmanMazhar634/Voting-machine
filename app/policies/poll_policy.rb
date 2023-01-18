# frozen_string_literal: true

# Handle Polls
class PollPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.admin? || user.candidate? || user.voter? 
  end

  def create?
    user.admin?
  end

  def new?
    user.admin?
  end

  def show?
    user.voter? || user.candidate? || user.admin?
  end

  def fetch_result?
    user.voter? || user.candidate? || user.admin?
  end
end
