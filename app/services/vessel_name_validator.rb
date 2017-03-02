class VesselNameValidator
  def initialize(name_approval)
    @name_approval = name_approval
  end

  def name_in_use?
    Register::Vessel
      .in_part(@name_approval.part)
      .where(name: @name_approval.name)
      .where(port_code: @name_approval.port_code)
      .where("name_approved_until is null or name_approved_until > now()")
      .exists?
  end

  def port_no_in_use?
    Register::Vessel
      .in_part(@name_approval.part)
      .where(port_no: @name_approval.port_no)
      .where(port_code: @name_approval.port_code)
      .where("name_approved_until is null or name_approved_until > now()")
      .exists?
  end
end
