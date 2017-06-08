class Report::AdvancedSearch::Section
  include ActiveSupport::Inflector

  def initialize(key)
    @key = key.to_sym
  end

  def title
    @key.to_s.titleize
  end

  def fieldset_id
    "filter_#{@key}"
  end

  def form_group_id(search_attr)
    "fields_#{@key}_#{search_attr.key}"
  end

  def field_label(search_attr)
    "filter_#{@key}_#{search_attr.key}"
  end

  def operator_field(search_attr)
    "#{@key}[#{search_attr.key}_operator]"
  end

  def text_input_field(search_attr)
    "filter[#{@key}][#{search_attr.key}]"
  end

  def add_search_criteria_label
    "add_criteria[toggle_#{@key}]"
  end

  def add_search_criteria_field
    "toggle_#{@key}"
  end
end
