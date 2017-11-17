def visit_registered_vessel
  login_to_part_3
  vessel = create(:registered_vessel)
  visit vessel_path(vessel)
end

def visit_unregistered_vessel
  login_to_part_3
  vessel = create(:unregistered_vessel)
  visit vessel_path(vessel)
end

def visit_section_notice_issued_vessel
  login_to_part_3
  vessel = create(:registered_vessel)
  vessel.issue_section_notice!
  visit vessel_path(vessel)
end
