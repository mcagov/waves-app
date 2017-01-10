class SequenceNumber::Generator < ApplicationRecord
  self.table_name = "sequence_numbers"

  class << self
    def reg_no!(registered_vessel)
      case registered_vessel.part.to_sym
      when :part_3
        SequenceNumber::PartThree.create!.generated_number
      end
    end
  end
end
