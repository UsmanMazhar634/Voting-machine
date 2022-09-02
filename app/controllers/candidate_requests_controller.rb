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
    @user = User.find(current_user.id)
    render :new
  end

  def create
    @request = CandidateRequest.new(params.require(:candidate_request).permit(:party, :voter_id, :constituency))
    if @request.save
      flash[:success] = "New request successfully added!"
      redirect_to candidate_requests_url
    else
      flash.now[:error] = "Request failed"
      render :new
    end
  end

  def approve
    @request = CandidateRequest.find(params[:id])
    @request.update_attribute(:status, "approved")
    @request.save!

    new_candidate = Candidate.create(user_id: params[:voter_id], party: params[:party], constituency:params[:constituency])
    new_candidate.save!
  end

end
