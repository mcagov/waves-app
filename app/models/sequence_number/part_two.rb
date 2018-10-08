class SequenceNumber::PartTwo < SequenceNumber::Generator
  protokoll :generated_number,
            start: SequenceNumber::Generator::REG_NO_START[:part_2],
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_2]
end
