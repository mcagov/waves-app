module TaskProcessing
  def check_task_processing_rules
    name_approval_required
    registered_vessel_required
    issues_csr
  end

  private

  def registered_vessel_required
    if rules_policy.registered_vessel_required &&
       @submission.registered_vessel.blank?
      render :registered_vessel_required
    end
  end

  def issues_csr
    if rules_policy.issues_csr
      return redirect_to submission_csr_path(@submission, task_id: @task.id)
    end
  end

  def rules_policy
    @rules_policy ||= Policies::Rules.new(@task)
  end

  def name_approval_required
    if Policies::Workflow.approved_name_required?(@submission)
      return redirect_to submission_name_approval_path(
        @submission, task_id: @task.id)
    end
  end
end
