class Report::AdvancedSearch::Criteria
  def initialize(attr_keys = [])
    @attr_keys = attr_keys
  end

  FilterAttr = Struct.new(:key, :name, :dataype) do
    def to_s
      name
    end
  end

  def filter_attributes
    @attr_keys.map do |attr_key|
      attr = attributes.detect { |key, _| key == attr_key }
      FilterAttr.new(attr_key, attr[1], attr[2])
    end
  end
end
