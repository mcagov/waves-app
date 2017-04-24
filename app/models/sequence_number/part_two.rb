class SequenceNumber::PartTwo < SequenceNumber::Generator
  protokoll :generated_number,
            start: 33333,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_2]
end
