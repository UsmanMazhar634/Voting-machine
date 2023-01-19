# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Polls', type: :request do
    let(:constituency) { create(:constituency) }
    let(:user) { create(:user, :admin, constituency: constituency.name) }
    let(:candidate_user) { create(:user, :candidate, constituency: constituency.name) }
    let(:voter_user) { create(:user, :voter, constituency: constituency.name) }

    let(:poll) { create(:poll, user_id: user.id) }

    let(:sign_in_required) { 'You need to sign in or sign up before continuing.' }
    let(:unknown_poll_id) { '123123' }

    let(:poll_params) do
        { start_date: Faker::Date.between(from: 2.days.ago, to: Time.zone.today) , end_date: Faker::Date.forward(days: 10), 
            user_id: 123 }
    end

    def poll_params_without_date
        {  end_date: Faker::Date.forward(days: 10), user_id: 123 }
    end

    describe 'when user is NOT signed in' do
        describe '#index' do
            it 'redirects to sign_in page' do
                get polls_path
                expect(flash[:alert]).to eq(sign_in_required)
            end
        end

        describe '#create' do
            it 'redirects to sign_in page' do
                post polls_path
                expect(flash[:alert]).to eq(sign_in_required)
            end
        end

        describe '#new' do
            it 'redirects to sign_in page' do
                get new_poll_path
                expect(flash[:alert]).to eq(sign_in_required)
            end
        end

        describe '#show' do
            it 'redirects to sign_in page' do
                get poll_path(poll.id)
                expect(flash[:alert]).to eq(sign_in_required)
            end
        end

        describe '#fetch_result' do
            it 'redirects to sign_in page' do
                get fetch_result_poll_path(poll.id)
                expect(flash[:alert]).to eq(sign_in_required)
            end
        end
    end

    # now for signed in  admin
    describe 'when admin is signed in' do
        before do
            sign_in user
        end

        describe '#create' do
            context 'when valid poll is given' do
                it 'admin creates a poll' do
                    post polls_path, params: { poll: poll_params }
                    expect(flash[:notice]).to eq('Poll has been created')
                end
            end

            context 'when invalid poll is given' do
                it 're-renders new template and poll not created' do
                    post polls_path, params: { poll: poll_params_without_date }
                    expect(response).to render_template(:new)
                end
            end
        end

        describe '#new' do
            context 'when new poll path is requested' do
                it 'renders the new template' do
                    get new_poll_path
                    expect(response).to render_template(:new)
                end
            end
        end
    
        describe '#index' do
            context 'when polls_path is requested' do
                it 'redirects to all polls page' do
                    get polls_path
                    expect(response).to render_template(:index)
                end
            end
        end

        describe '#show' do
            context 'when valid poll ID is given' do
                it 'renders show action of poll' do
                    get poll_path(poll)
                    expect(response).to render_template(:show)
                end
            end

            context 'when unknown poll ID is given' do
                it 'gives record not found alert' do
                    get poll_path(unknown_poll_id)
                    expect(flash[:alert]).to eq("Record Dont Exist  ")
                end
            end
        end

        describe '#fetch_result' do
            it 'renders fetch result action of poll when valid poll ID is given' do
                get fetch_result_poll_path(poll)
                expect(response).to render_template(:fetch_result)
            end

            it 'gives record not found alert when unknown poll ID is given' do
                get fetch_result_poll_path(unknown_poll_id)
                expect(flash[:alert]).to eq("Record Dont Exist  ")
            end
        end  
    end

    describe 'when candidate is signed in' do
        before do
            sign_in candidate_user
        end

        describe '#create' do
            it 'candidate is not authorized to create poll' do
                post polls_path, params: { poll: poll_params }
                expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
            end
        end

        describe '#new' do
            it 'candidate is not authorized to call new poll' do
                get new_poll_path, params: { poll: poll_params }
                expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
            end
        end
    end

    describe 'when voter is signed in' do
        before do
            sign_in voter_user
        end

        describe '#create' do
            it 'voter is not authorized to create poll' do
                post polls_path, params: { poll: poll_params }
                expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
            end
        end

        describe '#new' do
            it 'voter is not authorized to call new poll' do
                get new_poll_path, params: { poll: poll_params }
                expect(flash[:alert]).to eq('You are not Authorized to Perform this Action  ')
            end
        end
    end

end