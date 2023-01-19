# frozen_string_literal: true

# Candidate requests handled by admin
class CandidateRequestsController < ApplicationController
  before_action :set_candidate_request, only: %i[update]
  before_action :set_candidate_request_policy, only: %i[index new create]

  def index
    @requests = CandidateRequest.all
  end

  def new
    @request = CandidateRequest.new
  end

  def create
    @request = CandidateRequest.new(candidate_request_params)
    if @request.save
      flash[:notice] = t('candidate_request.create.req_approved')
      redirect_to :root
    else
      flash.now[:alert] = t('candidate_request.create.req_denied')
      render :new
    end
  end

  def update
    @request.approved!
    @request.change_candidate_status
    flash[:notice] = t('candidate_request.update.req_approved') if @request.save
    redirect_to :candidate_requests
  end

  private

  def candidate_request_params
    params.require(:candidate_request).permit(:party, :voter_id, :constituency, :image)
  end

  def set_candidate_request
    @request = CandidateRequest.find(params[:id])
    authorize @request
  end

  def set_candidate_request_policy
    authorize CandidateRequest
  end
end
