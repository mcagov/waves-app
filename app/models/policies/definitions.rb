class Policies::Definitions
  class << self
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

    def mortgageable?(obj)
      @part = obj.part.to_sym
      return true if @part == :part_1
      return true if @part == :part_2 && registration_type(obj) == :full
      false
    end

    def port_no?(obj)
      fishing_vessel?(obj)
    end
  end
end
