class TasksController < InternalPagesController
  def my_tasks
    @submissions =
      submission_scope.assigned_to(current_user).order("target_date asc")
  end

  def team_tasks
    @submissions = submission_scope.assigned.order("target_date asc")
  end

  def fee_entry
    @submissions =
      submission_scope
      .unassigned
      .where(officer_intervention_required: true)
      .order("target_date asc")
  end

  def refunds_due
    @submissions =
      submission_scope
      .unassigned
      .where(officer_intervention_required: true)
      .order("target_date asc")
  end

  def unclaimed
    @submissions =
      submission_scope
      .unassigned
      .where(officer_intervention_required: false)
      .order("target_date asc")
  end

  def incomplete
    @submissions = submission_scope.incomplete.order("target_date asc")
  end

  def referred
    @submissions = submission_scope.order("referred_until desc").referred
  end

  def cancelled
    @submissions = submission_scope.order("updated_at desc").cancelled
  end

  def next_task
    if (submission = submission_scope.assigned_to(current_user).first)
      return redirect_to submission_path(submission)
    else
      return redirect_to tasks_my_tasks_path
    end
  end

  private

  def submission_scope
    Submission
      .in_part(current_activity.part)
      .includes(:claimant, :declarations, payments: [:remittance])
      .paginate(page: params[:page], per_page: 50)
      .active
  end
end
