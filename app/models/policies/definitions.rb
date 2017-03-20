class Policies::Definitions
  class << self
    def approval_errors(submission)
      approval_errors = []

      return approval_errors if Task.new(submission.task) == :manual_override
      approval_errors << :vessel_frozen if frozen?(submission)
      approval_errors << :declarations_required if undeclared?(submission)
      approval_errors << :payment_required if unpaid?(submission)

      approval_errors
    end

    def frozen?(obj)
      obj.registration_status == :frozen
    end

    def undeclared?(submission)
      !submission.incomplete_declarations.empty?
    end

    def unpaid?(submission)
      AccountLedger.new(submission).awaiting_payment?
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
  end
end
