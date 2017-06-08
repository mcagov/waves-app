class Report::AdvancedSearch::Vessel < Report::AdvancedSearch::Criteria
  include ActionView::Helpers::TranslationHelper

  def initialize(filters)
    @filters = filters
  end

  def selected_attribute_keys
    return default_attribute_keys if @filters[:vessel].empty?
    @filters[:vessel].keys.map(&:to_sym)
  end

  def default_attribute_keys
    [:name, :hin]
  end

  def sections
    @sections ||= (custom_attributes + dynamic_attributes.compact)
  end

  private

  def custom_attributes
    [FilterAttr.new(:reg_no, "Official No", :string)]
  end

  def dynamic_attributes
    Register::Vessel.columns_hash.map do |key, column|
      label = "simple_form.labels.submission.vessel.#{key}"

      FilterAttr.new(
        key.to_sym,
        t(label),
        column_type(column.type)) if I18n.exists?(label)
    end
  end
end
