module Api::V1
  class DeclarationsController < ApiController
    before_action :load_declaration

    def show
      if @declaration
        render json: @declaration
      else
        render status: 404
      end
    end

    def update
      if @declaration
        @declaration.declared!
        render status: :ok
      else
        render status: 422
      end
    end

    private

    def load_declaration
      @declaration = Declaration.incomplete.find_by(id: params[:id])
    end
  end
end
