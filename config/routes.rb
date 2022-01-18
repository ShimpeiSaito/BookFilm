Rails.application.routes.draw do
  root "top#index"

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
end
