module PoliciesHelper
  def display_mortgages?(obj)
    Policies::Definitions.mortgageable?(obj)
  end

  def display_vessel_object?(attr, obj)
    Policies::Workflow.uses_vessel_attribute?(attr, obj)
  end

  def display_managers?(obj)
    Policies::Definitions.manageable?(obj)
  end
end
