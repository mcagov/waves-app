class Report::AdvancedSearch::Field
  include ActiveSupport::Inflector

  attr_reader :datatype

  def initialize(section, criteria, filter)
    @section_key = section.key
    @key = criteria.key
    @name = criteria.name
    @datatype = criteria.datatype
    @filter = filter
  end

  def title
    @name
  end

  def disabled?
    @filter.keys.blank?
  end

  def operator
    @filter[:operator]
  end

  def value
    @filter[:value]
  end

  def result_displayed?
    @filter[:result_displayed] == "1"
  end

  def row_id
    "fields_#{@section_key}_#{@key}"
  end

  def label
    "filter_#{@section_key}_#{@key}_value"
  end

  def select_operator_field
    "#{@section_key}[#{@key}][operator]"
  end

  def text_input_field
    "filter[#{@section_key}][#{@key}][value]"
  end

  def result_displayed_field
    "filter[#{@section_key}][#{@key}][result_displayed]"
  end

  def result_displayed_label_for
    "filter_#{@section_key}_#{@key}_result_displayed"
  end
end
