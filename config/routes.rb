Rails.application.routes.draw do
  namespace :authentication, as: '', path: '' do
    resources :users, only: [:new, :create, :edit, :update], path: '/register', path_names: { new: '/' }
    resources :sessions, only: [:new, :create, :destroy], path: '/login', path_names: { new: '/' }
    resources :passwords, only: [:edit, :update], path: '/password', path_names: { edit: '/' }
    get '/password_resets/edit', to: 'password_resets#edit', as: 'edit_password_reset'
    resources :password_resets, only: [:new, :create], path: '/password_resets', path_names: { new: '/' }
    patch '/password_resets', to: 'password_resets#update'
  end

  resources :pets
  resources :locals
  resources :cities
  resources :appointment_types
  resources :appointments

  get '/dashboard', to: 'home#dashboard', as: 'dashboard'
  get '/dashboard_admin', to: 'home#dashboard_admin', as: 'dashboard_admin'
  get '/welcome', to: 'home#welcome', as: 'welcome'
  root to: 'home#rooting'

  get "up" => "rails/health#show", as: :rails_health_check
end
