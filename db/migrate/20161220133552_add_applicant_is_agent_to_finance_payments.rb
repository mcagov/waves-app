class AddApplicantIsAgentToFinancePayments < ActiveRecord::Migration[5.0]
  def change
    add_column :finance_payments, :applicant_is_agent, :boolean, default: false
  end
end
