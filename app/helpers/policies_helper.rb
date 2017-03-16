module PoliciesHelper
  def display_mortgages?(obj)
    Policies::Definitions.mortgageable?(obj)
  end

  def display_port_no?(obj)
    Policies::Definitions.port_no?(obj)
  end
end
