class SearchController < InternalPagesController
  def index
    @search_results = submissions
  end

  def submissions
    @submissions = Search.submissions(params[:q], current_activity.part)

    respond_to do |format|
      format.js { render response_path }
      format.html { render :submissions }
    end
  end

  def vessels
    @vessels = Search.vessels(params[:q])

    respond_to do |format|
      format.js { render response_path }
    end
  end

  protected

  def response_path
    params[:response_path]
  end
end
