# frozen_string_literal: true

# Candidate requests handled by admin
class CandidateRequestsController < ApplicationController
  def index
    authorize CandidateRequest
    @requests = CandidateRequest.all
  end

  def new
    authorize CandidateRequest
    @request = CandidateRequest.new
  end

  def create
    authorize CandidateRequest
    @request = CandidateRequest.new(params.require(:candidate_request).permit(:party, :voter_id, :constituency, :image))
    if @request.save
      flash[:notice] = t('candidate_request.create.req_approved')
    else
      flash.now[:error] = t('candidate_request.create.req_denied')
    end
    render :new
  end

  def update
    @request = CandidateRequest.find(params[:id])
    authorize @request
    @request.approved!
    @request.save!

    if @request.save
      flash[:notice] = t('candidate_request.update.req_approved')
    else
      flash.now[:error] = t('candidate_request.update.req_denied')
    end
    redirect_to :candidate_requests
  end
end
