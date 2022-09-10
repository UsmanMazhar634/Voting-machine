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
  end

  def new
    authorize Poll
    @poll = Poll.new
  end

  # cast vote
  def show
    authorize Poll
    @poll = Poll.find(params[:id])
    @user = User.find(current_user.id)
    @candidates = Candidate.where(constituency: @user.constituency)
  end

  def fetch_result
    authorize Poll
    @poll = Poll.find(params[:id])
    @votes = Vote.where(poll_id: @poll.id)
    if params[:term].nil?
      @cons = Constituency.all.page(params[:page]).per(1)
    else
      @cons = Constituency.find(params[:term].to_i)
      render 'search_result', locals: { cons: @cons, poll: @poll, vote: @votes }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def poll_params
    params.require(:poll).permit(:start_date, :end_date)
  end
end
