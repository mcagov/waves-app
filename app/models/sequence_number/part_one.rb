class SequenceNumber::PartOne < SequenceNumber::Generator
  protokoll :generated_number,
            start: SequenceNumber::Generator::REG_NO_START[:part_1],
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_1]
end
