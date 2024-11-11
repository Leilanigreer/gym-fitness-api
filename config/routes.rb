Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "users/current" => "users#show"
  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  get "/exercises" => "exercises#index"
  get "/exercises/:id" => "exercises#show"

  get "/routines" => "routines#index"
  post "/routines" => "routines#create"
  patch "/routines/:id" => "routines#update"

  get "/workout_logs" => "workout_logs#index"
  post "/workout_logs" => "workout_logs#create"
  patch "/workout_logs/:id" => "workout_logs#update"


  # Defines the root path route ("/")
  # root "posts#index"
end
