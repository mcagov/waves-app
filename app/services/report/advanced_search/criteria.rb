class Report::AdvancedSearch::Criteria
  def initialize(selected_attribute_keys = [])
    @selected_attribute_keys = selected_attribute_keys || default_attribute_keys
  end

  attr_reader :selected_attribute_keys

  def default_attribute_keys
    []
  end

  FilterAttr = Struct.new(:key, :name, :dataype) do
    def to_s
      name
    end
  end

  def column_type(val)
    case val
    when :decimal, :integer then :numeric
    else
      :string
    end
  end
end
