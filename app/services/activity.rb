class Activity
  attr_reader :part

  PART_TYPES = [
    ["Part I", :part_1],
    ["Part II", :part_2],
    ["Part III", :part_3],
    ["Part IV", :part_4],
  ].freeze

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
    when :finance then "/finance/batches"
    else
      "/tasks/my-tasks"
    end
  end

  def view_mode
    @part == :part_3 ? :basic : :extended
  end

  def printable_templates
    templates =
      case @part
      when :part_1, :part_4
        default_printable_templates + [:csr_form]
      else
        default_printable_templates
      end

    templates.sort
  end

  private

  def default_printable_templates
    [
      :carving_and_marking,
      :registration_certificate,
      :cover_letter,
      :current_transcript,
      :historic_transcript,
      :provisional_certificate,
      :termination_notice,
    ]
  end
end
