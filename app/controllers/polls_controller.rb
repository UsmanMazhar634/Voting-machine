# frozen_string_literal: true

# Manage Polls
class PollsController < ApplicationController
  # GET /polls
  def index
    @polls = Poll.all
  end

  # POST /polls
  def create
    @poll = current_user.polls.create(poll_params)
  end

  def new
    @poll = Poll.new
  end

  def show
    @poll = Poll.find(params[:id])
    # only send the candidates of current constituency of user
    @user = User.find(current_user.id)
    @candidates = Candidate.where(constituency: @user.constituency)
  end

  def fetch_result
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
