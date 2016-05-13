Rails.application.routes.draw do
  resource :preregistration, only: [:new, :create]
end
