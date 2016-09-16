class RemoveConstraintFromRadioCallSign < ActiveRecord::Migration[5.0]
  def change
    change_column :vessels, :radio_call_sign, :string, null: true
  end
end
