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
      resources :countries, only: [:index]
      resources :payments, only: [:create]
      resources :new_registrations, only: [:create]
      resources :vessel_types, only: [:index]
    end
  end

  resources :submissions, only: [:show] do
    member do
      post :claim
      post :unclaim
      post :approve
    end
  end

  %w{ incomplete my-tasks team-tasks print-queue referred unclaimed }.each do |action|
    get "/tasks/#{ action }",
      controller: "tasks", action: action.gsub('-', '_')
  end

  root to: "dashboards#show"
end
