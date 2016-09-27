class SearchController < InternalPagesController
  def show
    lookup_vessel
    lookup_submission
  end

  private

  def lookup_vessel
    vessels = Search.by_vessel(params[:q].upcase)
    redirect_to vessel_path(vessels.first) unless vessels.empty?
  end

  def lookup_submission
    submissions = Search.by_submission(params[:q].upcase)
    redirect_to submission_path(submissions.first) unless submissions.empty?
  end
end
