class Report::AdvancedSearch::VesselCriteria < Report::AdvancedSearch::Criteria
  class << self
    include ActionView::Helpers::TranslationHelper

    def translation_for(attr)
      ref = "simple_form.labels.submission.vessel.#{attr}"
      I18n.exists?(ref) ? t(ref) : nil
    end
  end

  private

  def custom_attributes
    [Criterium.new(:reg_no, "Official No", :string)]
  end

  def dynamic_attributes
    Register::Vessel.columns_hash.map do |key, column|
      translation = Report::AdvancedSearch::VesselCriteria.translation_for(key)

      Criterium.new(
        key.to_sym,
        translation,
        column_type(column.type)) if translation
    end.compact
  end
end
