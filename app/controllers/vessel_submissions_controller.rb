class VesselSubmissionsController < InternalPagesController
  before_action :load_vessel

  def show
    @submission = Decorators::Submission.new(Submission.find(params[:id]))
  end

  private

  def load_vessel
    @vessel = Register::Vessel.find(params[:vessel_id])
  end
end
