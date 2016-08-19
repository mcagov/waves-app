module Clearance
  class UsersController < Clearance::BaseController
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false

    def new
      @user = user_from_params
      render template: "users/new"
    end

    def create
      @user = user_from_params

      if @user.save
        sign_in @user
        redirect_back_or url_after_create
      else
        render template: "users/new"
      end
    end

    private

    def avoid_sign_in
      warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " \
        "deprecated. Use `redirect_signed_in_users` instead. " \
        "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" \
        " or `skip_before_action :avoid_sign_in` as well"
      redirect_signed_in_users
    end

    def user_from_params
      email = user_params.delete(:email)
      password = user_params.delete(:password)

      Clearance.configuration.user_model.new(user_params).tap do |user|
        user.email = email
        user.password = password
      end
    end

    def user_params
      params[Clearance.configuration.user_parameter] || {}
    end
  end
end
