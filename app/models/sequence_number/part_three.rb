class SequenceNumber::PartThree < SequenceNumber::Generator
  protokoll :generated_number,
            start: SequenceNumber::Generator::REG_NO_START[:part_3],
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_3]
end
