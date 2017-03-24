class SequenceNumber::PartOne < SequenceNumber::Generator
  protokoll :generated_number,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_1]
end
