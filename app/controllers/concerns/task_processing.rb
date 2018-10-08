module TaskProcessing
  def check_task_processing_rules
    return render :registered_vessel_required if registered_vessel_required
    return render :registry_not_editable if registry_not_editable
    issues_csr
    name_approval_required
    registry_not_editable
  end

  private

  def registered_vessel_required
    rules_policy.registered_vessel_required &&
      @submission.registered_vessel.blank?
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
      if Policies::Activities.new(@task).update_registry_details
        return redirect_to submission_name_approval_path(
          @submission, task_id: @task.id)
      end
    end
  end

  def registry_not_editable
    rules_policy.registry_not_editable
  end
end
