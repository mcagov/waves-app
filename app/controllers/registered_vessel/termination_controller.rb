class RegisteredVessel::TerminationController < InternalPagesController
  before_action :load_vessel
  before_action :load_section_notice

  def create
    process_termination_notice
    flash[:notice] = "Termination Notice has been issued"

    redirect_to vessel_path(@vessel)
  end

  private

  def process_termination_notice
    PrintJob.create(
      printable: build_termination_notice,
      part: @vessel.part,
      template: :termination_notice,
      added_by: current_user)

    @vessel.issue_termination_notice!
  end

  def build_termination_notice
    Register::TerminationNotice.create(
      noteable: @vessel,
      actioned_by: current_user,
      subject: "Termination Notice",
      recipients: @section_notice.recipients,
      content:
        "Relates to Section Notice, issued on: #{@section_notice.created_at}")
  end

  def load_section_notice
    @section_notice = @vessel.section_notices.first
  end
end
