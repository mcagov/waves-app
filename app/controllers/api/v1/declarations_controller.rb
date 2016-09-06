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
        if declaration_params[:changeset]
          @declaration.update_attributes(
            changeset: declaration_params[:changeset])
        end
        @declaration.declare!
        render status: :ok
      else
        render status: 422
      end
    end

    private

    def load_declaration
      @declaration = Declaration.incomplete.find_by(id: params[:id])
    end

    def declaration_params
      data = params.require("data")
      data.require(:attributes).permit!
    end
  end
end
