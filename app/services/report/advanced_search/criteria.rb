class Report::AdvancedSearch::Criteria
  def initialize(filters)
    @filters = filters
  end

  def section_attributes
    @section_attributes ||= (custom_attributes + dynamic_attributes)
  end

  Criterium = Struct.new(:key, :name, :datatype) do
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

  private

  def custom_attributes
    []
  end

  def dynamic_attributes
    []
  end
end
