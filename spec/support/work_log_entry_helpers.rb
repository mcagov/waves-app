def creates_a_work_log_entry(description)
  expect(WorkLog.find_by(description: description)).to be_present
end

def does_not_create_a_work_log_entry
  expect(WorkLog.count).to eq(0)
end
