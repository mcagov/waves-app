Rails.application.routes.draw do
  resources :registration_wizard, only: [:show, :update]
end
