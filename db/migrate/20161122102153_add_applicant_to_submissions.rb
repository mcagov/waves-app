class AddApplicantToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :applicant_name, :string
    add_column :submissions, :applicant_email, :string
  end
end
