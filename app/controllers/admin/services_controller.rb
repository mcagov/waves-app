class Admin::ServicesController < InternalPagesController
  before_action :load_services

  def prices
  end

  def processes
  end

  private

  def load_services
    @services = Service.all
  end
end
