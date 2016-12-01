def creates_a_work_log_entry(logged_type, description)
  expect(
    WorkLog.where(logged_type: logged_type).last.description.to_sym
  ).to eq(description)
end
