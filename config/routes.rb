Rails.application.routes.draw do
  root to: "pages#home"

  # Devise routes for patients and psychologists
  devise_for :patients, path: "patients", controllers: {
    registrations: "patients/registrations",
    sessions: "patients/sessions"
  }

  devise_for :psychologists, path: "psychologists", controllers: {
    registrations: "psychologists/registrations",
    sessions: "psychologists/sessions"
  }

  # Profile routes for patients and psychologists
  get "patients/:id/profile", to: "patients#profile", as: "profile_patient"
  get "psychologists/:id/profile", to: "psychologists#profile", as: "profile_psychologist"



  # Appointments routes for patients
  resources :patients, only: [:show, :create, :update, :destroy, :index] do
    resources :appointments, only: [:index, :new, :create] do
      member do
        post 'book', to: 'appointments#book', as: 'book_patient_appointment'
        delete 'cancel', to: 'appointments#cancel', as: 'cancel_patient_appointment'
      end
    end
  end



  # Appointments routes for psychologists (full management)
  resources :psychologists, only: [ :show, :edit, :update, :destroy, :index ] do
    resources :appointments, only: [ :index, :new, :create, :edit, :update, :destroy ] do
      member do
        delete :cancel  # Psychologists can also cancel appointments
      end
    end
  end

  # Full CRUD routes for Messages and Testimonials for both patients and psychologists
  resources :messages, only: [ :create, :destroy, :edit, :update, :index, :new ]
  resources :testimonials, only: [ :new, :create, :edit, :update, :destroy ]
  resources :appointments, only: [ :create, :destroy ]


  # Contact routes
  get 'appointments', to: 'patients#appointments'
  get "contacts/new"
  post "contacts/create"
end
