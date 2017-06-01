class Policies::Definitions
  class << self
    def approval_errors(submission)
      return [] unless Task.new(submission.task).validates_on_approval?
      errors = vessel_errors(submission)

      unless Task.new(submission.task) == :manual_override
        errors << submission_errors(submission)
      end

      errors.flatten
    end

    def vessel_errors(submission)
      errors = []
      errors << :vessel_required if submission.vessel.name.blank?
      errors << :owners_required if submission.owners.empty?
      errors
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def submission_errors(submission)
      errors = []
      errors << :vessel_frozen if frozen?(submission)
      errors << :declarations_required if undeclared?(submission)
      errors << :payment_required if unpaid?(submission)
      errors << :carving_marking_receipt if cm_pending?(submission)
      errors << :shareholding_count if sh_incomplete?(submission)
      errors << :correspondent_required if no_correspondent?(submission)
      errors
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    def frozen?(obj)
      obj.registration_status == :frozen
    end

    def undeclared?(submission)
      Policies::Declarations.new(submission).incomplete?
    end

    def unpaid?(submission)
      AccountLedger.new(submission).awaiting_payment?
    end

    def cm_pending?(submission)
      return false if submission.carving_and_markings.empty?
      submission.carving_and_marking_received_at.blank?
    end

    def sh_incomplete?(submission)
      return false unless Policies::Workflow.uses_shareholding?(submission)
      ShareHolding.new(submission).status != :complete
    end

    def no_correspondent?(submission)
      return false if submission.part.to_sym == :part_3
      submission.correspondent.blank?
    end

    def fishing_vessel?(obj)
      @part = obj.part.to_sym
      return true if @part == :part_2
      return true if @part == :part_4 && registration_type(obj) == :fishing
      false
    end

    def registration_type(obj)
      if obj.respond_to?(:registration_type)
        obj.registration_type.try(:to_sym)
      elsif obj.respond_to?(:vessel)
        registration_type(obj.vessel)
      elsif obj.respond_to?(:submission)
        registration_type(obj.submission)
      end
    end

    def charterable?(obj)
      obj.part.to_sym == :part_4
    end

    def mortgageable?(obj)
      @part = obj.part.to_sym
      return true if @part == :part_1
      return true if @part == :part_2 && registration_type(obj) == :full
      false
    end

    def manageable?(obj)
      @part = obj.part.to_sym
      return true if @part == :part_1
      false
    end

    def part_3_online?(submission)
      submission.source.to_sym == :online && submission.part.to_sym == :part_3
    end

    def part_4_non_fishing?(obj)
      obj.part.to_sym == :part_4 && !fishing_vessel?(obj)
    end
  end
end
