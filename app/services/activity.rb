class Activity
  attr_reader :part

  def initialize(part)
    @part = part.to_sym
  end

  def to_s
    case @part
    when :part_1 then "Part I"
    when :part_2 then "Part II"
    when :part_3 then "Part III"
    when :part_4 then "Part IV"
    when :finance then "Finance"
    end
  end

  def bs_theme
    case @part
    when :part_1 then :success
    when :part_2 then :info
    when :part_3 then :warning
    when :part_4 then :danger
    when :finance then :primary
    end
  end

  def is?(part)
    @part == part
  end

  def root_path
    case @part
    when :finance then "/finance/payments/new"
    else
      "/tasks/my-tasks"
    end
  end
end
