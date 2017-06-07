class Report::AdvancedSearch::Criteria
  def initialize(selected_attribute_keys)
    @selected_attribute_keys = selected_attribute_keys || [:name]
  end

  FilterAttr = Struct.new(:key, :name, :dataype) do
    def to_s
      name
    end
  end

  def selected_attributes
    @selected_attributes ||=
      addable_attributes.select { |x| @selected_attribute_keys.include?(x.key) }
  end

  def column_type(val)
    case val
    when :decimal, :integer then :numeric
    else
      :string
    end
  end
end
