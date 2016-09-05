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
        @declaration.update_attributes(changeset: params[:owner])
        @declaration.declare!
        @declaration.submission.declared!
        render json: @declaration
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
