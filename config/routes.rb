Rails.application.routes.draw do
  root "static_pages#landing_page"
  get "privacy_policy", to: "static_pages#privacy_policy"

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
