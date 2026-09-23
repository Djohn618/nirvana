Rails.application.routes.draw do
  root "pages#home"

  # Auth
  get "signup", to: "registrations#new", as: :new_registration
  post "signup", to: "registrations#create", as: :registration

  get "login", to: "sessions#new", as: :new_session
  post "login", to: "sessions#create", as: :session
  delete "logout", to: "sessions#destroy", as: :destroy_session

  # Profile
  resource :profile, only: [:show, :edit, :update] do
  get :confirm, on: :collection
  end

  # Habits
  resources :habits, only: [:index, :new, :create, :destroy]

  # Daily check-in
  resources :habit_logs, only: [:new, :create]

  # Groups
  resources :groups, only: [:index, :show, :new, :create, :destroy] do
    resources :memberships, only: [:create, :destroy]
  end

  # Activity log
  resources :activities, only: [:index]

  # Admin
  namespace :admin do
    resources :users, only: [:index, :edit, :update, :destroy]
  end
end