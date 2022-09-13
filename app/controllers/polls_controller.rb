# frozen_string_literal: true

# Manage Polls
class PollsController < ApplicationController
  def index
    authorize Poll
    @polls = Poll.all
  end

  def create
    authorize Poll
    @poll = current_user.polls.create(poll_params)
    redirect_to :root
  end

  def new
    authorize Poll
    @poll = Poll.new
  end

  # Handled cast vote functionality
  def show
    authorize Poll
    @poll = Poll.find(params[:id])
    @candidates = Candidate.where(constituency: current_user.constituency)
  end

  def fetch_result
    authorize Poll
    @poll = Poll.find(params[:id])
    @votes = @poll.votes

    results = ConstituencyResults.new(params)
    @cons = results.constituency_results
    render 'search_result', locals: { cons: @cons, poll: @poll, vote: @votes } unless params[:term].nil?
  end

  private

  # Only allow a list of trusted parameters through.
  def poll_params
    params.require(:poll).permit(:start_date, :end_date)
  end
end
