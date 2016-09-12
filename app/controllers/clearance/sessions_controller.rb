module Clearance
  class SessionsController < Clearance::BaseController
    before_action :redirect_signed_in_users, only: [:new]
    skip_before_action :require_login,
                       only: [:create, :new, :destroy],
                       raise: false
    skip_before_action :authorize,
                       only: [:create, :new, :destroy],
                       raise: false

    def create
      @user = authenticate(params)

      sign_in(@user) do |status|
        if status.success?
          redirect_back_or url_after_create
        else
          flash[:notice] = status.failure_message
          redirect_back(fallback_location: root_path)
        end
      end
    end

    def destroy
      sign_out
      redirect_to url_after_destroy
    end

    def new
      render template: "sessions/new"
    end

    private

    def redirect_signed_in_users
      redirect_to(url_for_signed_in_users) if signed_in?
    end

    def url_after_create
      Clearance.configuration.redirect_url
    end

    def url_after_destroy
      root_path
    end

    def url_for_signed_in_users
      url_after_create
    end

    def user_for_paper_trail
      nil
    end
  end
end
