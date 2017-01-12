class UpdateOfficerInterventionRequired < ActiveRecord::Migration[5.0]
  def change
    change_column :submissions, :officer_intervention_required, :boolean, default: false
  end
end
