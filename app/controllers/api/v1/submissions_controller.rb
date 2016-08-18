module Api::V1
  class SubmissionsController < ApiController
    def create
      @submission = Submission.new(create_submission_params)

      if @submission.save
        render json: @submission, status: :created
      else
        render json: @submission, status: :unprocessable_entity,
                       serializer: ActiveModel::Serializer::ErrorSerializer
      end
    end

    private

    def create_submission_params
      data = params.require("data")
      data.require(:attributes).permit!
    end
  end
end
