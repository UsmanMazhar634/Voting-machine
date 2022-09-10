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
      flash[:notice] = 'New request successfully added!'
    else
      flash.now[:error] = 'Request failed'
    end
    render :new
  end

  def approve
    authorize CandidateRequest
    @request = CandidateRequest.find(params[:id])
    @request.update_attribute(:status, 'approved')
    @request.save!

    @user = User.find(params[:voter_id])
    @user.update_attribute(:role, 'candidate')
    @user.save!

    new_candidate = Candidate.create(user_id: params[:voter_id], party: params[:party],
                                     constituency: params[:constituency])
    new_candidate.save!
  end
end
