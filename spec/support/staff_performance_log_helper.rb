def creates_a_staff_performance_entry(activity)
  expect(StaffPerformanceLog.find_by(activity: activity)).to be_present
end
