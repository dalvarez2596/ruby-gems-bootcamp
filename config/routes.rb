Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users, only: [ :index, :edit, :show, :update ]
  get "home/index"
  get "home/activity"
  root "home#index"

  # get "privacy_policy", to: "static_pages#privacy_policy"

  # get "up" => "rails/health#show", as: :rails_health_check

  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
