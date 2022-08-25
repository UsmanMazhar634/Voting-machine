Rails.application.routes.draw do
  devise_for :users, controllers: { invitations: 'users/invitations' }
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#welcome_page'
  get 'welcome_page', to:'welcome#welcome_page'
  get 'dashboard_page', to:'welcome#dashboard_page'
end


