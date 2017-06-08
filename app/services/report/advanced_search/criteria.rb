class Report::AdvancedSearch::Criteria
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
end
