module PoliciesHelper
  def display_mortgages?(obj)
    Policies::Definitions.mortgageable?(obj)
  end
end
