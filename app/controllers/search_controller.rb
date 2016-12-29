class SearchController < InternalPagesController
  def show
    @part = current_activity.part
    lookup_vessel
    lookup_submission
  end

  private

  def lookup_vessel
    vessels = SimpleSearch.by_vessel(@part, params[:q].upcase)
    redirect_to vessel_path(vessels.first) unless vessels.empty?
  end

  def lookup_submission
    submissions = SimpleSearch.by_submission(@part, params[:q].upcase)
    redirect_to submission_path(submissions.first) unless submissions.empty?
  end
end
