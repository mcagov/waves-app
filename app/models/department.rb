class Department
  attr_reader :part

  def initialize(part, registration_type = "")
    @part = part.to_sym
    @registration_type = (registration_type || "").to_sym
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  def code
    @code ||=
      case @part
      when :part_1
        @registration_type == :pleasure ? :pleasure : :commercial
      when :part_2
        :fishing
      when :part_3
        :ssr
      when :part_4
        @registration_type == :fishing ? :fishing : :bareboat
      end
  end

  def contact_us
    if @part == :part_1
      "the commercial vessel team at comm.registry@mcga.gov.uk in the case of "\
      "an application for a commercial vessel and the pleasure vessel team at "\
      "part1.registry@mcga.gov.uk in the case of a pleasure vessel application"
    else
      "the #{description} at: #{email}"
    end
  end

  def description
    case code
    when :pleasure, :high_profile
      "Pleasure Vessel team"
    when :commercial
      "Commercial Vessel team"
    when :fishing
      "Fishing Vessel team"
    when :ssr
      "SSR team"
    when :bareboat
      "Bareboat Vessel team"
    end
  end

  def email
    case code
    when :pleasure, :high_profile
      "part1.registry@mcga.gov.uk"
    when :commercial, :bareboat
      "comm.registry@mcga.gov.uk"
    when :fishing
      "fishing.registry@mcga.gov.uk"
    when :ssr
      "ssr.registry@mcga.gov.uk"
    end
  end

  def phone
    case code
    when :pleasure
      "0203 90 85204"
    when :commercial, :bareboat, :high_profile
      "0203 90 85202"
    when :fishing
      "0203 90 85203"
    when :ssr
      "0203 90 85201"
    end
  end

  def part_of_register
    if code == :part_3
      "Part III of the UK Small Ships Register"
    else
      "#{Activity.new(@part)} of the UK Ships Register"
    end
  end

  def official_number_for_part
    code == :ssr ? "SSR Number" : "Official Number"
  end
end
