class SearchController < InternalPagesController
  def index
    @search_results = Search.all(params[:q])
  end
end
