Rails.application.routes.draw do
  root "top#index"

  namespace :admin do
    root "top#index"
    resource :adminsession, only: [:create, :destroy]
    resource :admins, except: [:destroy]
    resources :movies do
      get "search", on: :collection
    end
    resources :schedules
    resources :reservations do
      get "search", on: :collection
      get "updtime", on: :collection
      get "confirm", on: :collection
      get "nonconfirm", on: :collection
    end
  end

  resources :members, only: [:show, :create]
  resource :session, only: [:create, :destroy]
  resource :account, except: [:destroy]
  resource :password, only: [:show, :edit, :update]

  resources :movies do
    get "search", on: :collection
  end

  resources :theaters, only: [:index, :show]

  resources :theaters do
    resources :schedules, only: [:show] do
      get 'byday', on: :collection
    end
  end

  resource :reservation, except: [:destroy]
  post '/reservation/step1', to: 'reservations#step1'
  post '/reservation/step2', to: 'reservations#step2'
  post '/reservation/step3', to: 'reservations#step3'
end
