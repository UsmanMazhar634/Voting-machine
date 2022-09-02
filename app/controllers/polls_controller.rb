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

  private

    # Only allow a list of trusted parameters through.
    def poll_params
      params.require(:poll).permit(:start_date, :end_date)
    end
end
