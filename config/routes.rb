Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :target_dates, only: [:index]
    resources :tasks, only: [:index]
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

  resources :declarations, only: [:update] do
    resource :owners, only: [:update], controller: :declaration_owner
  end

  namespace :finance do
    resources :payments, only: [:new, :create, :show, :index]
  end

  resources :notifications, only: [:show] do
    member do
      post :cancel
      post :reject
      post :refer
    end
  end

  resources :submissions, only: [:new, :create, :show, :edit, :update] do
    resource :approval, controller: "submission/approvals", only: [:create]
    resource :states, controller: "submission/states", only: [:show] do
      member do
        post :claim
        post :unclaim
        post :claim_referral
      end
    end
    resource :finance_payment,
             only: [:show, :edit],
             controller: "submission/finance_payments" do
      member do
        patch :update
        patch :convert
      end
    end
    resource :correspondence,
             only: [:create],
             controller: "submission/correspondences"
    resource :delivery_addresses,
             only: [:update],
             controller: "submission/delivery_address"
    resource :documents,
             only: [:create],
             controller: "submission/documents"
    resource :vessel,
             only: [:update],
             controller: "submission/vessel"
  end

  resources :print_jobs, only: [:show, :index]

  resources :registrations, only: [:show]

  namespace :reports do
    resources :work_logs, only: [:index]
  end

  resources :vessels, only: [:show, :index] do
    resource :cold_storage,
             only: [:create],
             controller: "vessel/cold_storage"
    resource :current_transcript,
             only: [:show],
             controller: "vessel/current_transcript"
    resource :correspondence,
             only: [:create],
             controller: "vessel/correspondences"
    resource :historic_transcript,
             only: [:show],
             controller: "vessel/historic_transcript"
    resource :note,
             only: [:create],
             controller: "vessel/notes"
    resource :registration_certificate,
             only: [:show],
             controller: "vessel/registration_certificate"
  end

  %w(
    incomplete my-tasks team-tasks
    referred unclaimed cancelled next-task
  ).each do |action|
    get "/tasks/#{action}",
        controller: :tasks,
        action: action.tr("-", "_")
  end

  %w(
    registration_certificate cover_letter
    current_transcript historic_transcript
  ).each do |template|
    get "/print_queue/#{template}",
        controller: :print_jobs,
        action: :index,
        template: template
  end

  get "/search", controller: :search, action: :show
  root to: "dashboards#show"
end
