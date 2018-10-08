class Admin::ApplicationTypesController < InternalPagesController
  def index
    @application_types = load_application_types
  end

  private

  def load_application_types
    ApplicationType.all.map do |application_type|
      ApplicationType.new(application_type[1])
    end
  end
end
