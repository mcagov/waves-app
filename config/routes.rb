Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"

  constraints Clearance::Constraints::SignedIn.new(&:admin?) do
    root to: "admin/dashboards#show", as: :admin_root
  end

  constraints Clearance::Constraints::SignedIn.new do
    root to: "dashboards#show", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "clearance/sessions#new"
  end

  namespace :api do
    namespace :v1 do
      resources :declarations, only: [:show, :update]
      resources :new_registrations, only: [:create]
      resources :payments, only: [:create]
      resources :vessel_types, only: [:index]
      resources :client_sessions, only: [:create]
      resources :vessels, only: [:show]
    end
  end

  resources :submissions, only: [:show] do
    member do
      post :claim
      post :unclaim
      post :approve
      post :claim_referral
    end
    resource :correspondence,
             only: [:create],
             controller: :submission_correspondences
    resource :vessels,
             only: [:update],
             controller: :submission_vessel
    resource :delivery_addresses,
             only: [:update],
             controller: :submission_delivery_address
  end

  resources :declarations, only: [:update] do
    resource :owners, only: [:update], controller: :declaration_owner
  end

  resources :notifications, only: [:show] do
    member do
      post :cancel
      post :reject
      post :refer
    end
  end

  namespace :registration do
    resources :certificates, only: [:show]
    resources :cover_letter, only: [:show]
  end

  resources :vessels, only: [:show, :index] do
    resource :correspondence,
             only: [:create],
             controller: :vessel_correspondences

    resource :note,
             only: [:create],
             controller: :vessel_notes
  end

  %w(
    incomplete my-tasks team-tasks print-queue
    referred unclaimed rejected cancelled next-task
  ).each do |action|
    get "/tasks/#{action}",
        controller: "tasks",
        action: action.tr("-", "_")
  end

  get "/search", controller: :search, action: :show

  root to: "dashboards#show"
end
