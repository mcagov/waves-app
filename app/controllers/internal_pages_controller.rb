class InternalPagesController < ApplicationController
  layout "internal"

  before_action :require_login
  before_action :set_paper_trail_whodunnit

  def user_for_paper_trail
    current_user
  end
end
