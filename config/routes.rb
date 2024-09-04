Rails.application.routes.draw do
  root to: "pages#home"

  # Devise routes for patients and psychologists
  devise_for :patients, path: 'patients', controllers: {
    registrations: "patients/registrations",
    sessions: "patients/sessions"
  }

  devise_for :psychologists, path: 'psychologists', controllers: {
    registrations: "psychologists/registrations",
    sessions: "psychologists/sessions"
  }

  # Define profile routes for patients and psychologists
  get 'patients/:id/profile', to: 'patients#profile', as: 'profile_patient'
  get 'psychologists/:id/profile', to: 'psychologists#profile', as: 'profile_psychologist'

  # Additional pages
  get "signup_page", to: "pages#signup_page", as: :signup_page

  # Nested resources for patients and psychologists
  resources :patients, only: [:show, :edit, :update, :destroy] do
    resources :appointments, only: [:index, :new, :create, :edit, :update]
    resources :messages, only: [:create, :destroy]
  end

  resources :psychologists, only: [:show, :edit, :update, :destroy] do
    resources :appointments, only: [:index, :new, :create, :edit, :update]
    resources :messages, only: [:create, :destroy]
  end

  # General appointments routes
  resources :appointments, only: [:index, :show, :edit, :update, :destroy] do
    member do
      patch :book
      patch :cancel
    end
  end

  # Testimonials routes
  resources :testimonials, only: [:edit, :update, :destroy]

  # Calendar and contacts routes
  get 'calendar', to: 'calendar#index'
  get 'contacts/new'
  post 'contacts/create'

  match '*path', to: 'pages#home', via: :all

end
