class Policies::Workflow
  class << self
    def approved_name_required?(submission)
      return false if submission.part.to_sym == :part_3
      return false if submission.registered_vessel
      true
    end
  end
end
