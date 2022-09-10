# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#dashboard_page'
  # get 'welcome_page', to: 'welcome#welcome_page'
  # get 'dashboard_page', to: 'welcome#dashboard_page'
  resources :users, only: %i[index show]

  # get 'users/:id/become_candidate', to: 'candidate_requests#become_candidate', as: :become_candidate

  # get 'become_candidate', to: 'candidate_requests#index', as: 'candidate_requests'
  # get 'become_candidate/new', to: 'candidate_requests#new', as: 'new_candidate_request'
  # get 'become_candidate/:id', to: 'candidate_requests#show', as: 'candidate_request'
  # post 'become_candidate', to: 'candidate_requests#create'

  # get 'users/:id/display_voters', to: 'users#display_voters', as: 'display_voters'

  resources :candidate_requests, only: %i[index show new create update]

  post 'approve_request/:id', to: 'candidate_requests#approve', as: 'approve_request'

  resources :polls do
    get :fetch_result, on: :member
    resources :votes
  end
end
