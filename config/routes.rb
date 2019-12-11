Rails.application.routes.draw do
  apipie
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do
        resources :tracking_sleeps
        resource :relationships, only: [:create, :destroy]
      end
    end
  end
end
