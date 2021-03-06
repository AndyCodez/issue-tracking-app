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
  get 'mark_in_progress' => 'issues#change_status_to_in_progress'
  get 'mark_resolved' => 'issues#change_status_to_resolved'
  get 'mark_closed' => 'issues#change_status_to_closed'
  get 'mark_open' => 'issues#change_status_to_open'
  get 'choose_expert' => 'issues#choose_expert'
  get 'new_account_activation' => 'account_activations#new'
  
  resources :users
  resources :account_activations, only: [:new, :edit, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :issues
  resources :comments, only: [:create]
end
