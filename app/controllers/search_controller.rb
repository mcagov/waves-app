class SearchController < InternalPagesController
  before_action :load_submissions, only: [:index, :submissions]
  before_action :load_vessels, only: [:index, :vessels]

  def index
  end

  def submissions
    respond_to do |format|
      format.js { render response_path }
    end
  end

  def vessels
    respond_to do |format|
      format.js { render response_path }
    end
  end

  def global
    @submissions = Search.submissions(params[:q])
    @vessels = Search.vessels(params[:q])

    respond_to do |format|
      format.js { render response_path }
    end
  end

  protected

  def response_path
    params[:response_path]
  end

  def load_submissions
    @submissions = Search.submissions(params[:q], current_activity.part)
  end

  def load_vessels
    @vessels = Search.vessels(params[:q], current_activity.part)
  end
end
