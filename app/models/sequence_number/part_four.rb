class SequenceNumber::PartFour < SequenceNumber::Generator
  protokoll :generated_number,
            start: 1,
            pattern: SequenceNumber::Generator::REG_NO_PATTERNS[:part_4]
end
