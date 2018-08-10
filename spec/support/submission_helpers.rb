def create_submission_from_api!
  data =
    JSON.parse(
      File.read("spec/fixtures/new_registration.json")
    )["data"]["attributes"]

  Submission.create(data)
end

def visit_fee_entry
  login_to_part_3
  visit "/finance_payments/unattached_refunds"
  click_on("Fees Received")
  within(".finance-payment") do
    find(".payment-date").trigger("click")
  end
end
