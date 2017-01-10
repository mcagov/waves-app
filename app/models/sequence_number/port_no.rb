class SequenceNumber::PortNo < SequenceNumber::Generator
  protokoll :generated_number, scope_by: :context, pattern: "#"
end
