module PoliciesHelper
  def display_csr_forms?(obj)
    Policies::Workflow.uses_csr_forms?(obj)
  end

  def display_ec_no?(obj)
    Policies::Definitions.fishing_vessel?(obj)
  end

  def display_charterers?(obj)
    Policies::Definitions.charterable?(obj)
  end

  def display_mortgages?(obj)
    Policies::Definitions.mortgageable?(obj)
  end

  def display_vessel_object?(attr, obj)
    Policies::Workflow.uses_vessel_attribute?(attr, obj)
  end

  def display_editable_registration_type?(obj)
    Policies::Workflow.uses_editable_registration_type?(obj)
  end

  def display_managers?(obj)
    Policies::Definitions.manageable?(obj)
  end

  def display_extended_engines?(obj)
    Policies::Workflow.uses_extended_engines?(obj)
  end

  def display_extended_owners?(obj)
    Policies::Workflow.uses_extended_owners?(obj)
  end

  def display_managing_owner?(obj)
    Policies::Workflow.uses_managing_owner?(obj)
  end

  def display_shareholding?(obj)
    Policies::Workflow.uses_shareholding?(obj)
  end
end
