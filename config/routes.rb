Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get "home/index"
  get "activity", to: "home#activity"
  get "analytics", to: "home#analytics"

  resources :enrollments do
    get :my_students, on: :collection
  end

  resources :courses do
    get :purchased, :pending_review, :created, :unapproved, on: :collection
    member do
      patch :approve
      patch :unapprove
    end
    resources :lessons
    resources :enrollments, only: [ :new, :create ]
  end
  resources :users, only: [ :index, :edit, :show, :update ]

  namespace :charts do
    get "users_per_day"
    get "enrollments_per_day"
    get "course_popularity"
    get "money_makers"
  end
  # es mejor tener un namespace que asi como abajo 
  # get "charts/users_per_day", to: "charts#users_per_day"
  # get "charts/enrollments_per_day", to: "charts#enrollments_per_day"
  # get "charts/course_popularity", to: "charts#course_popularity"
  # get "charts/money_makers", to: "charts#money_makers"


  # get "privacy_policy", to: "static_pages#privacy_policy"

  # get "up" => "rails/health#show", as: :rails_health_check

  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
