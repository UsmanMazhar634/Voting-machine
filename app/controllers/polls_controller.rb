# frozen_string_literal: true

# Manage Polls
class PollsController < ApplicationController
  before_action :set_poll, only: %i[show fetch_result]
  before_action :set_poll_policy, only: %i[index create new]

  def index
    @polls = Poll.all
  end

  def create
    @poll = current_user.polls.create(poll_params)
    redirect_to :root
  end

  def new
    @poll = Poll.new
  end

  def show
    @candidates = Candidate.where(constituency: current_user.constituency)
  end

  def fetch_result
    @votes = @poll.votes
    @cons = ConstituencyResults.new(params).constituency_results
  end

  private

  def poll_params
    params.require(:poll).permit(:start_date, :end_date)
  end

  def set_poll
    @poll = Poll.find(params[:id])
    authorize @poll
  end

  def set_poll_policy
    authorize Poll
  end
end
