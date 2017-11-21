class RegisteredVessel::ForcedClosureController < InternalPagesController
  before_action :load_vessel

  def create
    complete_forced_closure_submission
    log_work!(@submission, @submission, :forced_closure)

    redirect_to vessel_path(@vessel)
  end

  private

  def complete_forced_closure_submission
    @submission =
      Builders::CompletedSubmissionBuilder.create(
        :forced_closure,
        current_activity.part,
        @vessel,
        current_user)

    Builders::ClosedRegistrationBuilder
      .create(@submission, Time.now, Task.new(:forced_closure).description)
  end
end
