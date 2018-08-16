require "rails_helper"

describe ApplicationProcessor do

  # This spec covers scenarios encountered by the following services

  # #activities
  # "generate_new_5_year_registration",
  # "update_registry_details",
  # "record_transcript_event",
  # "generate_provisional_registration",
  # "generate_duplicate_certificate",
  # "close_registration",
  # "issue_csr"

  # #print_templates
  # "registration_certificate",
  # "cover_letter",
  # "provisional_certificate",
  # "current_transcript",
  # "historic_transcript",
  # "csr_form"
  context "#run" do
    let(:approval_params) { {} }
    let(:submission) { task.submission }

    subject do
      described_class.run(task, approval_params)
    end

    context "generate_new_5_year_registration" do
      let(:approval_params) { { registration_starts_at: "01/01/2011" } }

      let(:task) { create(:task, :generate_new_5_year_registration) }

      before do
        expect(Builders::RegistrationBuilder)
          .to receive(:create)
          .with(submission, registered_vessel, "01/01/2011", nil)
      end

      it { subject }
    end
  end
end


# let(:approval_params) do
#   {
#     registration_starts_at: "01/01/2011",
#     closure_at: "02/02/2012",
#     closure_reason: "a reason",
#   }
# end


    # context "with a registered_vessel" do
    #   let(:submission) do
    #     create(:submission,
    #            application_type: task,
    #            registered_vessel: create(:registered_vessel))
    #   end

    #   context "change_vessel" do
    #     let(:task) { :change_vessel }

    #     before do
    #       expect_registry_builder
    #       expect_registration_builder
    #       dont_expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "change_address" do
    #     let(:task) { :change_address }

    #     before do
    #       expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       dont_expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "duplicate_certificate" do
    #     let(:task) { :duplicate_certificate }

    #     before do
    #       dont_expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "renewal" do
    #     let(:task) { :renewal }

    #     before do
    #       expect_registry_builder
    #       expect_registration_builder
    #       dont_expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "closure" do
    #     let(:task) { :closure }

    #     before do
    #       expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_closed_registration_builder
    #       dont_expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "current_transcript" do
    #     let(:task) { :current_transcript }

    #     before do
    #       dont_expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "current_transcript (electronic_delivery)" do
    #     let(:task) { :current_transcript }

    #     before do
    #       submission.changeset["electronic_delivery"] = true
    #       dont_expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       dont_expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "historic_transcript" do
    #     let(:task) { :historic_transcript }

    #     before do
    #       dont_expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "issue_csr" do
    #     let(:task) { :issue_csr }

    #     before do
    #       dont_expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "mortgage" do
    #     let(:task) { :mortgage }
    #     let(:registered_vessel) { create(:registered_vessel) }

    #     before do
    #       expect_registry_builder
    #       expect_mortgage_registration_builder
    #       dont_expect_cloned_registration_builder
    #       dont_expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "mortgage_other" do
    #     let(:task) { :mortgage_other }
    #     let(:registered_vessel) { create(:registered_vessel) }

    #     before do
    #       expect_registry_builder
    #       expect_mortgage_registration_builder
    #       dont_expect_cloned_registration_builder
    #       dont_expect_print_job_builder
    #     end

    #     it { subject }
    #   end

    #   context "manual_override" do
    #     let(:task) { :manual_override }

    #     before do
    #       expect_registry_builder
    #       dont_expect_registration_builder
    #       expect_cloned_registration_builder
    #       dont_expect_print_job_builder
    #     end

    #     it { subject }
    #   end
    # end

# def expect_registry_builder
#   expect(Builders::RegistryBuilder)
#     .to receive(:create)
#     .with(submission, approval_params)
#     .and_return(registered_vessel)
# end

# def dont_expect_registry_builder
#   expect(Builders::RegistryBuilder).not_to receive(:create)
# end

# def expect_registration_builder
#   expect(Builders::RegistrationBuilder)
#     .to receive(:create)
#     .with(submission, registered_vessel, "01/01/2011", nil)
# end

# def dont_expect_registration_builder
#   expect(Builders::RegistrationBuilder).not_to receive(:create)
# end

# def expect_mortgage_registration_builder
#   expect(Builders::RegistrationBuilder)
#     .to receive(:create)
#     .with(
#       submission,
#       registered_vessel,
#       registered_vessel.registered_at,
#       registered_vessel.registered_until)
# end

# def expect_closed_registration_builder
#   expect(Builders::ClosedRegistrationBuilder)
#     .to receive(:create)
#     .with(submission, "02/02/2012", "a reason", nil)
# end

# def dont_expect_cloned_registration_builder
#   expect(Builders::ClonedRegistrationBuilder).not_to receive(:create)
# end

# def expect_cloned_registration_builder
#   expect(Builders::ClonedRegistrationBuilder)
#     .to receive(:create).with(submission)
# end

# def expect_print_job_builder
#   expect(Builders::PrintJobBuilder).to receive(:create)
# end

# def dont_expect_print_job_builder
#   expect(Builders::PrintJobBuilder).not_to receive(:create)
# end
