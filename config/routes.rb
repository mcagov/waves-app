Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :target_dates, only: [:index]
    resources :tasks, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :declarations, only: [:show, :update]
      resources :submissions, only: [:create]
      resources :payments, only: [:create]
      resources :vessel_types, only: [:index]
      resources :client_sessions, only: [:create]
      resources :vessels, only: [:show]
    end
  end

  namespace :finance do
    resources :batches, only: [:index, :create] do
      resources :payments, only: [:new, :create, :show, :index]
    end
  end

  resources :notifications, only: [:show] do
    member do
      post :cancel
      post :reject
      post :refer
    end
  end

  resources :submissions, only: [:new, :create, :show, :edit, :update] do
    resources :agent,
              controller: "submission/agents", only: [:update, :destroy]
    resource :approval, controller: "submission/approvals", only: [:create]
    resources :declarations,
              controller: "submission/declarations",
              only: [:create, :update, :destroy] do
      member do
        post :complete
      end
    end
    resource :signature,
             controller: "submission/signatures",
             only: [:show, :update]
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
        patch :link
        patch :unlink
      end
    end
    resource :correspondence,
             only: [:create],
             controller: "submission/correspondences"
    resource :documents,
             only: [:create],
             controller: "submission/documents"
  end

  resources :print_jobs, only: [:show, :index]

  resources :registrations, only: [:show]

  namespace :reports do
    resources :work_logs, only: [:index]
  end

  resources :vessels, only: [:show, :index] do
    resource :closure,
             only: [:create],
             controller: "vessel/closure"
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
    resource :manual_override,
             only: [:create],
             controller: "vessel/manual_override"
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

  get "/search", controller: :search, action: :index
  get "/search/submissions", controller: :search, action: :submissions
  get "/search/vessels", controller: :search, action: :vessels

  root to: "dashboards#show"
end
