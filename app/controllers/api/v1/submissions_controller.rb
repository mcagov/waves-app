module Api
  module V1
    class SubmissionsController < ApiController
      def create
        @submission = Submission.new(create_submission_params)
        init_applicant

        if @submission.save
          render json: @submission, status: :created
        else
          render json: @submission,
                 status: :unprocessable_entity,
                 serializer: ActiveModel::Serializer::ErrorSerializer
        end
      end

      private

      def create_submission_params
        data = params.require("data")
        data.require(:attributes).permit!
      end

      def init_applicant
        applicant = @submission.owners.first
        return unless applicant

        @submission.applicant_name = applicant.name
        @submission.applicant_email = applicant.email
      end
    end
  end
end
