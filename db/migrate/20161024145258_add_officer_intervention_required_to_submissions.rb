class AddOfficerInterventionRequiredToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :officer_intervention_required, :boolean
  end
end
