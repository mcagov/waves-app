class SequenceNumber::PartOne < SequenceNumber::Generator
  protokoll :generated_number,
            start: 2000000,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_1]
end
