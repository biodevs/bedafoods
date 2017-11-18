Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :restaurants
      resources :plates
    end
  end
end