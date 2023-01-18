# frozen_string_literal: true

# Manage Votes Controller
class VotesController < ApplicationController
  before_action :set_vote_policy, only: %i[index new create]

  def index
    @votes = Vote.all
  end

  def new
    @vote = Vote.new
  end

  def create
    @vote = current_user.votes.create(vote_params)
    redirect_to @vote.poll
  end

  private

  def set_vote_policy
    authorize Vote
  end

  def vote_params
    params.require(:vote).permit(:candidate_id, :poll_id, :constituency_id)
  end
end
