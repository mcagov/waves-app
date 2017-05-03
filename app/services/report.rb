class Report
  class << self
    def build(template, filters)
      eval("Report::#{template.to_s.camelize}.new(#{filters})")
    end
  end
end
