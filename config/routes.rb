Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'

  get 'about' => 'static_pages#about'

  get 'help' => 'static_pages#help'

  get 'signup' => 'users#new'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'show_issue' => 'issues#show'

  resources :users
  resources :account_activations, only: [:new, :edit, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :issues
end
