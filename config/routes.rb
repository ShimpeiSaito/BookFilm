Rails.application.routes.draw do
  root "top#index"

  resources :members
  resource :session, only: [:create, :destroy]
  resource :account, except: [:destroy]
  resource :password, only: [:show, :edit, :update]

  resources :movies do
    get "search", on: :collection
  end
end
