Rails.application.routes.draw do
  root 'dashboard#index'
  get 'dashboard/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :users do
        resources :tracking_sleeps
      end
    end
  end
end
