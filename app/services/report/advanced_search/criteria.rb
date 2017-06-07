class Report::AdvancedSearch::Criteria
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
