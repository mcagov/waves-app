class Admin::ServicesController < InternalPagesController
  def index
    @services = Service.all
  end
end
