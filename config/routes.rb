JSONAPI::Home::Engine.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :v1 do
    resources :jsonapi_home_resources, controller: :resources, path: "jsonapi-home-resources", only: [:index, :show]
  end
end
