class RegisteredVessel::SectionNoticeController < InternalPagesController
  before_action :load_vessel

  def create
    if section_notice_params[:recipient_ids].present?
      process_section_notice
      flash[:notice] = "Section Notice has been issued"
    else
      flash[:notice] =
        "Recipient must be selected. Section Notice has not been issued."
    end

    redirect_to vessel_path(@vessel)
  end

  def destroy
    cancel_section_notice
    flash[:notice] = "Section Notice has been cancelled"

    redirect_to vessel_path(@vessel)
  end

  private

  def process_section_notice
    PrintJob.create(
      printable: build_section_notice,
      part: @vessel.part,
      template: :section_notice)

    @vessel.issue_section_notice!
  end

  def build_section_notice
    Register::SectionNotice.create(
      noteable: @vessel,
      actioned_by: current_user,
      subject: section_notice_params[:subject],
      content: section_notice_params[:content],
      recipients: section_notice_recipients)
  end

  def cancel_section_notice
    @vessel.restore_active_state!
    Note.create(
      noteable: @vessel,
      content: "Section Notice cancelled",
      actioned_by: current_user)
  end

  def section_notice_params
    params
      .require(:register_section_notice)
      .permit(:subject, :content, recipient_ids: [])
  end

  def section_notice_recipients
    section_notice_params[:recipient_ids].map do |id|
      customer = Customer.find(id)
      customer.compacted_address.unshift(customer.name)
    end
  end
end
