class SequenceNumber::Generator < ApplicationRecord
  self.table_name = "sequence_numbers"

  REG_NO_PATTERNS =
    {
      part_1: "6#####",
      part_2: "C3#####",
      part_3: "SSR2#####",
      part_4: "8#####",
    }.freeze

  class << self
    def reg_no!(part)
      case part.to_sym
      when :part_1
        SequenceNumber::PartOne.create!.generated_number

      when :part_2
        SequenceNumber::PartTwo.create!.generated_number

      when :part_3
        SequenceNumber::PartThree.create!.generated_number

      when :part_4
        SequenceNumber::PartFour.create!.generated_number
      end
    end

    def port_no!(port_code)
      SequenceNumber::PortNo.create!(context: port_code).generated_number.to_i
    end
  end
end
