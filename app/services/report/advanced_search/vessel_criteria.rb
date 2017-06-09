class Report::AdvancedSearch::VesselCriteria < Report::AdvancedSearch::Criteria
  private

  def custom_attributes
    [Criterium.new(:reg_no, "Official No", :string)]
  end

  def dynamic_attributes
    Register::Vessel.columns_hash.map do |key, column|
      label = "simple_form.labels.submission.vessel.#{key}"

      Criterium.new(
        key.to_sym,
        t(label),
        column_type(column.type)) if I18n.exists?(label)
    end.compact
  end
end
