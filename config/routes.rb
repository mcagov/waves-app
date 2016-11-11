Rails.application.routes.draw do
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

  namespace :finance do
    resources :payments, only: [:new, :create, :show, :index]
  end

  resources :submissions, only: [:show, :edit, :update] do
    resource :states, controller: "submission/states", only: [:show] do
      member do
        post :claim
        post :unclaim
        post :approve
        post :claim_referral
      end
    end
    resource :correspondence,
             only: [:create],
             controller: "submission/correspondences"
    resource :vessel,
             only: [:update],
             controller: "submission/vessel"
    resource :delivery_addresses,
             only: [:update],
             controller: "submission/delivery_address"
  end

  resources :manual_entries, only: [:new, :edit, :create, :show, :update] do
    member do
      patch :convert_to_application
    end
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
    resources :cover_letters, only: [:show]
  end

  namespace :print_queue do
    resources :certificates, only: [:index]
    resources :cover_letters, only: [:index]
  end

  resources :vessels, only: [:show, :index] do
    resources :submissions,
              only: :show,
              controller: "vessel_submissions"
    resource :correspondence,
             only: [:create],
             controller: "vessel/correspondences"
    resource :note,
             only: [:create],
             controller: "vessel/notes"
  end

  %w(
    incomplete my-tasks team-tasks
    referred unclaimed rejected cancelled next-task
  ).each do |action|
    get "/tasks/#{action}",
        controller: "tasks",
        action: action.tr("-", "_")
  end

  get "/search", controller: :search, action: :show
  get "/target_dates", controller: :target_dates, action: :index
  root to: "dashboards#show"
end
