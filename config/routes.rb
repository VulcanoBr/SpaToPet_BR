Rails.application.routes.draw do
  namespace :authentication, as: '', path: '' do
    resources :users, only: [:new, :create, :edit, :update], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
    resources :passwords, only: [:edit, :update], path: '/password', path_names: { edit: '/' }
    get '/password_resets/edit', to: 'password_resets#edit', as: 'edit_password_reset'
    resources :password_resets, only: [:new, :create], path: '/password_resets', path_names: { new: '/' }
    patch '/password_resets', to: 'password_resets#update'
  end

  resources :pets do
    member do
      delete :destroy_photo
    end
  end
  resources :locals
  resources :cities
  resources :appointment_types

  resources :appointments do
    get 'approval_payment', to: 'appointments#approval_payment'

    post 'payment_approved', on: :member
    get 'payment_approved', on: :member
    post 'payment_unapproved', on: :member
    get 'payment_unapproved', on: :member
    #post '/payment_approved', to: 'appointments#payment_approved'
    #post 'approval_payment', to: 'appointments#payment_approved'
    #get '/payment_approval', to: 'appointments#payment_approved'
    #get '/payment_approved', to: 'appointments#payment_approved'
    #get '/payment_unapproved', to: 'appointments#payment_unapproved'
    #post '/appointments/:appointment_id/payment_approved', to: 'appointments#payment_approved', as: 'payment_approved_appointment'

  end
  resources :payments

  get 'approval_appointment', to: 'appointments#approval_appointment'

  get "/profile/:id", to: "users#show", as: "profile"
  delete "/profile/:id", to: "users#destroy"

  get '/dashboard', to: 'home#dashboard', as: 'dashboard'
  get '/dashboard_admin', to: 'home#dashboard_admin', as: 'dashboard_admin'
  get '/welcome', to: 'home#welcome', as: 'welcome'
  root to: 'home#rooting'

  post '/set_locale/:locale', to: 'application#set_locale', as: :set_locale
  get '/set_locale/:locale', to: 'application#set_locale'

  get "up" => "rails/health#show", as: :rails_health_check
end
