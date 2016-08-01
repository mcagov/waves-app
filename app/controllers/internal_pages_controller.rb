class InternalPagesController < ApplicationController
  layout "internal"

  before_action :require_login
end
