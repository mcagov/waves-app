class Policies::Definitions
  class << self
    def part_1?(obj)
      obj.part.to_sym == :part_1
    end

    def part_2?(obj)
      obj.part.to_sym == :part_2
    end

    def part_3?(obj)
      obj.part.to_sym == :part_3
    end

    def part_3_online?(submission)
      part_3?(submission) && submission.source.to_sym == :online
    end

    def part_4?(obj)
      obj.part.to_sym == :part_4
    end

    def part_4_non_fishing?(obj)
      part_4?(obj) && registration_type(obj) != :fishing
    end

    def part_4_fishing?(obj)
      part_4?(obj) && registration_type(obj) == :fishing
    end

    def frozen?(obj)
      obj.registration_status == :frozen
    end

    def undeclared?(submission)
      Policies::Declarations.new(submission).incomplete?
    end

    def unpaid?(submission)
      AccountLedger.new(submission).awaiting_payment?
    end

    def fishing_vessel?(obj)
      part_2?(obj) || part_4_fishing?(obj)
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
      return true if part_1?(obj)
      return true if part_2?(obj) && registration_type(obj) == :full
      false
    end

    def manageable?(obj)
      part_1?(obj) || part_4?(obj)
    end

    def fee_category(submission)
      part =
        if part_2?(submission)
          "part_2_#{simple_or_full(submission)}".to_sym
        else
          submission.part.to_sym
        end

      "#{part}_#{submission.task}"
    end

    def simple_or_full(submission)
      (submission.vessel.registration_type || "simple").to_sym
    end
  end
end
