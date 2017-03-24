class SequenceNumber::PartTwo < SequenceNumber::Generator
  protokoll :generated_number,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_2]
end
