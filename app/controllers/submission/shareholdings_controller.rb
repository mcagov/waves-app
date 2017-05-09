class Submission::ShareholdingsController < InternalPagesController
  before_action :load_submission

  def show
    respond_to do |format|
      format.js
    end
  end
end
