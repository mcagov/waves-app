module Api::V1
  class DeclarationsController < ApiController
    def show
      @declaration = Declaration.incomplete.find_by(id: params[:id])

      if @declaration
        render json: @declaration
      else
        render status: 404
      end
    end
  end
end
