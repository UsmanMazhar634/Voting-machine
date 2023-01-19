# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CandidateRequests', type: :request do
  let(:constituency) { create(:constituency) }
  let(:user) { create(:user, :admin, id: 123, constituency: constituency.name) }
  let(:candidate_user) { create(:user, :candidate, constituency: constituency.name) }
  let(:voter_user) { create(:user, :voter, constituency: constituency.name) }

  let(:candidate_request) { create(:candidate_request, image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/a1.jpeg'))) }

  let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }

  let(:candidate_request_params) do
    { voter_id: 123, party: 'XYZ', status: 0, constituency: '123' }
  end

  let(:invalid_candidate_request_params) do
    { party: 'XYZ', status: 1, constituency: '123' }
  end

  describe 'when user is NOT signed in' do
    describe '#index' do
      it 'redirects to sign_in page' do
        get candidate_requests_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#new' do
      it 'redirects to sign_in page' do
        get new_candidate_request_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#create' do
      it 'redirects to sign_in page' do
        post candidate_requests_path
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end

    describe '#update' do
      it 'redirects to sign_in page' do
        put candidate_request_path(candidate_request.id)
        expect(flash[:alert]).to eq(sign_in_required)
      end
    end
  end

  # now for signed in
  describe 'when admin is signed in' do
    before do
      sign_in user
    end

    describe '#new' do
      it 'admin is not authorized to call new action for candidate request' do
        get new_candidate_request_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#create' do
      it 'admin is not authorized to create candidate request' do
        post candidate_requests_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#index' do
      context 'when candidate_requests_path is requested' do
        it 'redirects to all candidate requests page' do
          get candidate_requests_path
          expect(response).to render_template(:index)
        end
      end
    end

    describe '#update' do
      context 'when new candidate request is approved' do
        it 'renders the update template' do
          user.save!
          put candidate_request_path(candidate_request.id)
          expect(flash[:notice]).to eq('Your Request is approved successfully')
        end
      end
    end
  end

  describe 'when candidate is signed in' do
    before do
      sign_in candidate_user
    end

    describe '#index' do
      it 'candidate is not authorized to view candidate requests' do
        get candidate_requests_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#new' do
      it 'candidate is not authorized to call a new action for candidate request' do
        get new_candidate_request_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#create' do
      it 'candidate is not authorized to create candidate request' do
        post candidate_requests_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#update' do
      it 'candidate is not authorized to approve candidate request' do
        put candidate_request_path(candidate_request.id)
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end
  end

  describe 'when voter is signed in' do
    before do
      sign_in voter_user
    end

    describe '#index' do
      it 'voter is not authorized to view candidate requests' do
        get candidate_requests_path
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#new' do
      context 'when new candidate request is created' do
        it 'renders the new template' do
          get new_candidate_request_path
          expect(response).to render_template(:new)
        end
      end
    end

    describe '#update' do
      it 'voter is not authorized to approve candidate request' do
        put candidate_request_path(candidate_request.id)
        expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
      end
    end

    describe '#create' do
      context 'when valid candidate request is given by voter' do
        it 'creates a candidate request' do
          post candidate_requests_path, params: { candidate_request: candidate_request_params }
          expect(flash[:notice]).to eq('Your Request is created successfully')
        end
      end

      context 'when invalid candidate request is given by voter' do
        it 're-renders new template and candidate request not created' do
          post candidate_requests_path, params: { candidate_request: invalid_candidate_request_params }
          expect(flash[:alert]).to eq('Your Request is not created')
        end
      end
    end
  end
end
