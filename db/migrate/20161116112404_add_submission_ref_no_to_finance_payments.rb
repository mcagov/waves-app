class AddSubmissionRefNoToFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :submission_ref_no, :string, index: true
  end
end
