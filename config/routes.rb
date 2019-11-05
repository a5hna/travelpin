Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards, except: [:index] do
    resources :board_users, only: [:index, :new, :create]
    resources :experiences, only: [:new, :create]
    resources :day_schedules, only: [:show, :new, :create]
  end

  resources :board_users, only: [:destroy]
  resources :experiences, only: [:edit, :update, :destroy]
  resources :day_schedules, only: [:destroy]
  resources :friends, only: [:index, :new, :create, :destroy]

  get 'dashboard', to: "pages#dashboard"
  get 'board', to: "pages#user_board", as: :user_boards
end
