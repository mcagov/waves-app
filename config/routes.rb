Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :application_types, only: [:index]
    resources :common_mortgagees
    resources :fees, only: [:index]
    resources :reports, only: [:show, :index]
    resources :services, only: [:index] do
      collection do
        get :prices
        get :processes
      end
    end
    resources :target_dates, only: [:index]
    resources :users
    resources :notifications, only: [:index] do
      collection do
        post :approve_all
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :client_sessions, only: [:create]
      resources :declarations, only: [:show, :update]
      resources :payments, only: [:create]
      resources :submissions, only: [:create]
      resources :vessel_types, only: [:index]
      resources :vessels, only: [:index, :show]
    end
  end

  namespace :finance do
    resources :batches, only: [:index, :create, :update, :destroy] do
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

  resources :finance_payments, only: [:show, :update] do
    collection do
      get :unattached_payments
      get :unattached_refunds
    end
    member do
      patch :update
      patch :link
    end
    resources :payments,
              controller: "finance_payments/payments",
              only: [:update]
    resources :submissions,
              controller: "finance_payments/submissions",
              only: [:new, :create]
  end

  resources :submissions, only: [:new, :create, :show, :edit, :update] do
    collection do
      get :open
      get :closed
    end

    member do
      put :close
    end

    resources :agent,
              constraints: ->(request) { request.format == :js },
              controller: "submission/agents", only: [:update, :destroy]

    resources :asset,
              controller: "submission/assets", only: [:destroy]
    resources :applicant,
              constraints: ->(request) { request.format == :js },
              controller: "submission/applicants", only: [:update]

    resources :application_approvals,
              controller: "submission/application_approvals",
              only: [:new, :create]

    resources :beneficial_owners,
              constraints: ->(request) { request.format == :js },
              controller: "submission/beneficial_owners",
              only: [:create, :update, :destroy]

    resource :carving_and_marking,
             controller: "submission/carving_and_markings",
             only: [:new, :create] do
      member do
        post :update_state
      end
    end

    resource :csr,
             controller: "submission/csr",
             only: [:show, :update, :destroy]

    resources :directed_bys,
              constraints: ->(request) { request.format == :js },
              controller: "submission/directed_bys",
              only: [:create, :update, :destroy]

    resources :managed_bys,
              constraints: ->(request) { request.format == :js },
              controller: "submission/managed_bys",
              only: [:create, :update, :destroy]

    resource :correspondence,
             only: [:create, :destroy],
             controller: "submission/correspondences"

    resource :correspondent,
             constraints: ->(request) { request.format == :js },
             only: [:update],
             controller: "submission/correspondents"

    resources :declaration_group_members,
              constraints: ->(request) { request.format == :js },
              controller: "submission/declaration_group_members",
              only: [:create, :destroy]

    resources :declaration_groups,
              constraints: ->(request) { request.format == :js },
              controller: "submission/declaration_groups",
              only: [:create, :update]

    resources :declarations,
              constraints: ->(request) { request.format == :js },
              controller: "submission/declarations",
              only: [:create, :update, :destroy] do
      member do
        post :complete, constraints: ->(request) { request.format == :html }
      end
    end

    resources :charterers,
              constraints: ->(request) { request.format == :js },
              controller: "submission/charterers",
              only: [:create, :update, :destroy] do
      resources :charter_parties,
                constraints: ->(request) { request.format == :js },
                controller: "submission/charterers/charter_parties",
                only: [:create, :update, :destroy]
    end

    resources :documents,
              only: [:create, :update, :destroy],
              controller: "submission/documents"

    resources :engines,
              constraints: ->(request) { request.format == :js },
              controller: "submission/engines",
              only: [:create, :update, :destroy]

    resources :managers,
              constraints: ->(request) { request.format == :js },
              controller: "submission/managers",
              only: [:create, :update, :destroy]

    resources :mortgages,
              constraints: ->(request) { request.format == :js },
              controller: "submission/mortgages",
              only: [:create, :update, :destroy]

    resource :official_no,
             constraints: ->(request) { request.format == :js },
             controller: "submission/official_no",
             only: [:update]

    resource :managing_owner,
             constraints: ->(request) { request.format == :js },
             only: [:update],
             controller: "submission/managing_owners"

    resource :name_approval,
             controller: "submission/name_approvals",
             only: [:show, :update, :destroy]

    resources :notes,
              constraints: ->(request) { request.format == :js },
              only: [:create, :update],
              controller: "submission/notes"

    resources :representatives,
              constraints: ->(request) { request.format == :js },
              controller: "submission/representatives",
              only: [:update, :destroy]

    resource :shareholding,
             constraints: ->(request) { request.format == :js },
             controller: "submission/shareholdings",
             only: [:show]

    resources :tasks,
              controller: "submission/tasks",
              only: [:index, :create, :destroy, :update, :show] do
      collection do
        post :confirm
      end

      member do
        post :claim
        post :unclaim
        post :claim_referral
        get  :validate
        post :skip_cm_receipt
        post :complete
      end

      resource :notification,
               controller: "submission/task/notifications",
               only: [:show] do
        member do
          post :cancel
          post :refer
        end
      end
    end
  end

  resources :print_jobs, only: [:show, :index, :update]

  resources :vessels, only: [:show, :index] do
    resources :assets,
              only: [:destroy],
              controller: "registered_vessel/assets"

    resources :csrs,
              only: [:show, :update],
              controller: "registered_vessel/csrs"

    resource :cold_storage,
             only: [:create],
             controller: "registered_vessel/cold_storage"

    resource :current_transcript,
             only: [:show],
             controller: "registered_vessel/current_transcript"

    resource :correspondence,
             only: [:create, :destroy],
             controller: "registered_vessel/correspondences"

    resource :historic_transcript,
             only: [:show],
             controller: "registered_vessel/historic_transcript"

    resource :note,
             only: [:create],
             controller: "registered_vessel/notes"

    resource :official_no,
             controller: "registered_vessel/official_no",
             only: [:update]

    resource :registration_certificate,
             only: [:show],
             controller: "registered_vessel/registration_certificate"

    resource :section_notice,
             only: [:create, :destroy],
             controller: "registered_vessel/section_notice"

    resource :termination,
             only: [:create],
             controller: "registered_vessel/termination"

    resource :tasks,
             only: [:create],
             controller: "registered_vessel/tasks"
  end

  [
    :part_1, :part_2, :part_3, :part_4
  ].each do |part|
    get "/#{part}/work_logs",
        controller: :work_logs,
        action: :index,
        part: part
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
    carving_and_marking registration_certificate
    duplicate_registration_certificate
    cover_letter current_transcript historic_transcript csr_form
    provisional_certificate termination_notice renewal_reminder_letter
    mortgagee_reminder_letter ihs section_notice forced_closure
  ).each do |template|
    get "/print_queue/#{template}",
        controller: :print_jobs,
        action: :index,
        template: template
  end

  resources :work_logs, only: [:index]

  resources :carving_and_markings, only: [] do
    collection do
      get :outstanding
    end
  end

  get "/search", controller: :search, action: :index
  get "/search/submissions", controller: :search, action: :submissions
  get "/search/vessels", controller: :search, action: :vessels
  get "/search/global", controller: :search, action: :global

  root to: "dashboards#show"
end
