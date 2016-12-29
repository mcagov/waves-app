class SearchController < InternalPagesController
  def index
    @search_results = PgSearch.multisearch(params[:q])
  end
end
