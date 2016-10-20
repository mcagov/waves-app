class Builders::ManualEntryBuilder
  class << self
    def convert_to_application(submission)
      @submission = submission
      @finance_payment = @submission.payment.remittance

      build_changeset
      build_declarations

      @submission
    end

    private

    def build_changeset
      changeset =
        {
          vessel_info: {
            name: @finance_payment.vessel_name,
            reg_no: @finance_payment.vessel_reg_no,
          },
        }
      @submission.update_attribute(:changeset, changeset)
    end

    def build_declarations
      if @finance_payment.applicant_name.present?
        Builders::DeclarationBuilder.create(
          @submission, build_owners)
      end
    end

    def build_owners
      [
        {
          name: @finance_payment.applicant_name,
          email: @finance_payment.applicant_email,
        },
      ]
    end
  end
end
