class Report::AdvancedSearch::VesselCriteria < Report::AdvancedSearch::Criteria
  class << self
    include ActionView::Helpers::TranslationHelper

    def translation_for(attr)
      ref = "simple_form.labels.submission.vessel.#{attr}"
      I18n.exists?(ref) ? t(ref) : nil
    end
  end

  def column_attributes
    return [] unless @filters[:vessel]

    @column_attributes =
      @filters[:vessel].keys.map do |key|
        key if @filters[:vessel][key].keys.include?(:result_displayed)
      end.compact
  end

  def headings
    column_attributes.map do |key|
      section_attributes.find { |a| a.key == key }.name
    end
  end

  private

  def custom_attributes
    [Criterium.new(:reg_no, "Official No", :string)]
  end

  def dynamic_attributes
    attributes =
      Register::Vessel.columns_hash.map do |key, column|
        name = Report::AdvancedSearch::VesselCriteria.translation_for(key)

        Criterium.new(
          key.to_sym,
          name,
          column_type(column.type)) if name
      end

    attributes.compact.sort_by(&:name)
  end
end
