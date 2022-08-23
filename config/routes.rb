Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'users#index'
  get 'welcome_page', to:'welcome#welcome_page'
  get 'dashboard_page', to:'welcome#dashboard_page'

end
