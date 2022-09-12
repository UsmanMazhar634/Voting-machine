# frozen_string_literal: true

# Manage Votes Controller
class VotesController < ApplicationController
  before_action :set_vote

  def index
    authorize Vote
    @votes = Vote.all
  end

  def new
    authorize Vote
    @vote = Vote.new
  end

  def create
    authorize Vote
    @vote = current_user.votes.create(vote_params)
    redirect_to @vote.poll
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def vote_params
    params.require(:vote).permit(:candidate_id, :poll_id, :constituency_id)
  end
end
