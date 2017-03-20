Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :target_dates, only: [:index]
    resources :tasks, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      resources :client_sessions, only: [:create]
      resources :declarations, only: [:show, :update]
      resources :payments, only: [:create]
      resources :submissions, only: [:create]
      resources :vessel_types, only: [:index]
      resources :vessels, only: [:show]
    end
  end

  namespace :finance do
    resources :batches, only: [:index, :create, :update] do
      member do
        post :close
        post :re_open
        post :lock
      end

      resources :payments

      collection do
        get :this_week
        get :this_month
        get :this_year
      end
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

    resources :beneficial_owners,
              controller: "submission/beneficial_owners",
              only: [:create, :update, :destroy]

    resource :carving_and_marking,
             controller: "submission/carving_and_marking",
             only: [:create] do
      member do
        post :update_state
      end
    end

    resource :csr,
             controller: "submission/csr",
             only: [:show, :update, :destroy]

    resources :directed_bys,
              controller: "submission/directed_bys",
              only: [:create, :update, :destroy]

    resource :correspondence,
             only: [:create],
             controller: "submission/correspondences"

    resource :correspondent,
             only: [:update],
             controller: "submission/correspondents"

    resources :declaration_group_members,
              controller: "submission/declaration_group_members",
              only: [:create, :destroy]

    resources :declaration_groups,
              controller: "submission/declaration_groups",
              only: [:create, :update]

    resources :declarations,
              controller: "submission/declarations",
              only: [:create, :update, :destroy] do
      member do
        post :complete
      end
    end

    resources :charterers,
              controller: "submission/charterers",
              only: [:create, :update, :destroy]

    resources :documents,
              only: [:create, :update, :destroy],
              controller: "submission/documents"

    resources :engines,
              controller: "submission/engines",
              only: [:create, :update, :destroy]

    resources :managers,
              controller: "submission/managers",
              only: [:create, :update, :destroy]

    resources :mortgages,
              controller: "submission/mortgages",
              only: [:create, :update, :destroy]

    resource :official_no,
             controller: "submission/official_no",
             only: [:update]

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

    resource :managing_owner,
             only: [:update],
             controller: "submission/managing_owners"

    resource :name_approval,
             controller: "submission/name_approvals",
             only: [:show, :update]

    resources :representatives,
              controller: "submission/representatives",
              only: [:update, :destroy]

    resource :shareholding,
             controller: "submission/shareholdings",
             only: [:show]

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
  end

  resources :print_jobs, only: [:show, :index, :update]

  resources :registrations, only: [:show]

  namespace :reports do
    resources :work_logs, only: [:index]
  end

  resources :vessels, only: [:show, :index] do
    resource :closure,
             only: [:create],
             controller: "registered_vessel/closure"

    resource :cold_storage,
             only: [:create],
             controller: "registered_vessel/cold_storage"

    resource :current_transcript,
             only: [:show],
             controller: "registered_vessel/current_transcript"

    resource :correspondence,
             only: [:create],
             controller: "registered_vessel/correspondences"

    resource :historic_transcript,
             only: [:show],
             controller: "registered_vessel/historic_transcript"

    resource :note,
             only: [:create],
             controller: "registered_vessel/notes"

    resource :registration_certificate,
             only: [:show],
             controller: "registered_vessel/registration_certificate"

    resource :manual_override,
             only: [:create],
             controller: "registered_vessel/manual_override"
  end

  %w(
    incomplete my-tasks team-tasks fee-entry
    referred unclaimed cancelled next-task
  ).each do |action|
    get "/tasks/#{action}",
        controller: :tasks,
        action: action.tr("-", "_")
  end

  %w(
    carving_and_marking registration_certificate cover_letter
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
