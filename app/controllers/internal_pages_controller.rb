class InternalPagesController < ApplicationController
  layout "private"

  before_action :require_login
end
