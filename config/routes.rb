# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users, controllers: { invitations: 'users/invitations' }
  resources :users, only: %i[index show]

  resources :welcome, only: %i[index]

  resources :candidate_requests, except: %i[edit destroy]

  resources :polls, except: %i[edit update destroy] do
    get :fetch_result, on: :member
    resources :votes, only: %i[index new create]
  end
end
