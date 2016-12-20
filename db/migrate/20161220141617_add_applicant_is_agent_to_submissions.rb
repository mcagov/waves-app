class AddApplicantIsAgentToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :applicant_is_agent, :boolean, default: false
  end
end
