class Policies::Workflow
  class << self
    def approved_name_required?(submission)
      return false if submission.part.to_sym == :part_3
      true
    end
  end
end
