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
    if @request.save!
      flash.now[:notice] = t('candidate_request.create.req_approved')
    else
      flash.now[:alert] = @request.errors.full_message.to_sentence
    end
    render :new
  end

  def update
    @request.approved!
    @request.change_candidate_status
    if @request.save!
      flash[:notice] = t('candidate_request.update.req_approved')
    else
      flash[:alert] = @request.errors.full_message.to_sentence
    end
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
