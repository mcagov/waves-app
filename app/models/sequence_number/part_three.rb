class SequenceNumber::PartThree < SequenceNumber::Generator
  protokoll :generated_number,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_3]
end
