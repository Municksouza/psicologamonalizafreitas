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

  # Profile routes for patients and psychologists
  get 'patients/:id/profile', to: 'patients#profile', as: 'profile_patient'
  get 'psychologists/:id/profile', to: 'psychologists#profile', as: 'profile_psychologist'

  # Appointment routes
  resources :appointments do
    member do
      post :book  # POST route for patients to book an appointment
      post :cancel  # POST route for patients to cancel a booking
    end
    collection do
      get :index_json  # GET route to fetch appointments in JSON format for the calendar
    end
  end

  # Full CRUD routes for Patients
  resources :patients, only: [:show, :edit, :update, :destroy, :index] do
    resources :appointments, only: [:index, :new, :create, :edit, :update, :destroy, :show] do
      collection do
        get :index_json  # For fetching events in JSON format for FullCalendar
      end
    end
    resources :messages, only: [:create, :destroy, :edit, :update, :index, :new]  # Full CRUD for messages
  end

  # Full CRUD routes for Psychologists
  resources :psychologists, only: [:show, :edit, :update, :destroy, :index] do
    resources :appointments, only: [:index, :new, :create, :edit, :update, :destroy, :show]
    resources :messages, only: [:create, :destroy, :edit, :update, :index, :new]  # Full CRUD for messages
  end

  # Testimonials routes
  resources :testimonials, only: [:edit, :update, :destroy]

  # Calendar and contacts routes
  get 'calendar', to: 'calendar#index'
  get 'contacts/new'
  post 'contacts/create'
end
