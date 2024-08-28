Rails.application.routes.draw do
  get "messages/index"
  get "messages/create"
  get "messages/destroy"
  get "appointments/index"
  get "appointments/show"
  get "appointments/new"
  get "appointments/create"
  get "appointments/edit"
  get "appointments/update"
  get "appointments/destroy"
  get "home/index"
  root "home#index"
  devise_for :patients, controllers: { sessions: "sessions" }
  devise_for :psychologists, controllers: { sessions: "sessions" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :patients do
    resources :appointments, only: [ :new, :create, :index ]
    resources :messages, only: [ :create, :destroy ]
  end

  resources :appointments, only: [ :index, :show, :edit, :update, :destroy ]





  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
