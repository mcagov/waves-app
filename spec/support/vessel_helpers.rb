def visit_registered_vessel
  login_to_part_3
  vessel = create(:completed_submission).registered_vessel
  visit vessel_path(vessel)
end
