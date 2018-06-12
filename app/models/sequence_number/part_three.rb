class SequenceNumber::PartThree < SequenceNumber::Generator
  protokoll :generated_number,
            start: 200000,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_3]
end
