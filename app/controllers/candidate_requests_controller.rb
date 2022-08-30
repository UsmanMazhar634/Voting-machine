class CandidateRequestsController < ApplicationController
  def index
    @requests = CandidateRequest.all
    render :index
  end

  def show
    @request = CandidateRequest.find(params[:id])
    render :show
  end

  def new
    @request = CandidateRequest.new
    render :new
  end

  def create
    @request = CandidateRequest.new(params.require(:candidate_request).permit(:party , :voter_id))
    if @request.save
      flash[:success] = "New request successfully added!"
      redirect_to candidate_requests_url
    else
      flash.now[:error] = "Request failed"
      render :new
    end
  end

end
