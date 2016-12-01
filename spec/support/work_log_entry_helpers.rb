def creates_a_work_log_entry(logged_type, description)
  expect(
    WorkLog.where(logged_type: logged_type).last.description.to_sym
  ).to eq(description)
end

def does_not_create_a_work_log_entry
  expect(WorkLog.count).to eq(0)
end
