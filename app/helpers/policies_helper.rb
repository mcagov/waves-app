module PoliciesHelper
  def display_charterers?(obj)
    Policies::Definitions.charterable?(obj)
  end

  def display_mortgages?(obj)
    Policies::Definitions.mortgageable?(obj)
  end

  def display_vessel_object?(attr, obj)
    Policies::Workflow.uses_vessel_attribute?(attr, obj)
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

  def display_shareholding?(obj)
    Policies::Workflow.uses_shareholding?(obj)
  end
end
