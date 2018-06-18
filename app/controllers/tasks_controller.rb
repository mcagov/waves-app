class TasksController < InternalPagesController
  def my_tasks
    @submissions =
      submission_scope.assigned_to(current_user).order("target_date asc")
  end

  def team_tasks
    @submissions = submission_scope.assigned.order("target_date asc")
  end

  def unclaimed
    @filter_registration_type = params[:filter_registration_type] || "all"

    query =
      submission_scope
      .unassigned

    query = filter_by_registration_type(query)
    @submissions = query.order("target_date asc")
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

  def filter_by_registration_type(query)
    case @filter_registration_type
    when "all"
      query
    when "not_set"
      query.where("(changeset#>>'{vessel_info, registration_type}' is null)")
    else
      query.where(
        "(UPPER(changeset#>>'{vessel_info, registration_type}') = ?)",
        @filter_registration_type.upcase)
    end
  end
end
