Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
             controller: "clearance/passwords",
             only: [:create, :edit, :update]
  end

  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"

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
      resources :registrations, only: [:create]
      resources :vessel_types, only: [:index]
    end
  end

  resources :registrations, only: [:show]

  get "/tasks/:action", controller: "tasks"

  root to: "dashboards#show"
end
