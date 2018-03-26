Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount JSONAPI::Home::Engine, at: "/"

  namespace :v1 do
    resources :accounts
    resources :posts, only: [:index, :update, :destroy]
  end

  root to: "v1/accounts#index"
end
