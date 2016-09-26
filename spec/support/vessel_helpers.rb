def visit_registered_vessel
  login_to_part_3
  visit vessel_path(create(:register_vessel))
end
