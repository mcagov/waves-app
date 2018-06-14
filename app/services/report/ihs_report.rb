class Report::IhsReport < Report
  def title
    "IHS/Fairplay"
  end

  def xls_title
    :hidden
  end

  def first_sheet_title
    "IHS Fairplay"
  end

  def results # rubocop:disable Metrics/MethodLength
    build_results(
      Register::Vessel
        .joins(:current_registration)
        .includes([:owners, :managers, charterers: [:charter_parties]])
        .where("vessels.frozen_at is null")
        .where("
          (registrations.closed_at is null OR
          registrations.closed_at > ?)", 6.months.ago)
        .where("registrations.registered_until > ?", Time.zone.today)
        .where(
          "(part = 'part_1') OR "\
          "(part = 'part_4' AND "\
          "registration_type != 'fishing')")
        .where("gross_tonnage > 100.0"))
  end

  def headings # rubocop:disable Metrics/MethodLength
    %w(
      Source IMO_Number ShipName GrossTonnage69Convention MMSI
      PortOfRegistry OfficialNumber CallSign GrossTonnageFlagConvention
      NetTonnage69Convention NetTonnageFlagConvention DeadWeight
      YearOfBuild MonthOfBuild Shipbuilder CountryOfShipbuilderDecode
      LRFShipTypeDecode AdminShipTypeDescription IMO_RegOwnerNumber
      RegOwnerNameAdminNamestyle RegOwnerNameLRFNamestyle
      RegOwnerRegisteredAddressAdmin RegOwnerCountryOfRegistrationDecode
      RegOwnerDateFounded IMO_DOC_CompanyNumber DOC_Auditor
      DOC_Company_Name DOC_CompanyCountryDomicileDecode
      DOC_CompanyCountryRegistrationDecode DOC_CompanyFoundedDate
      DOC_CompanyFullAddress DOC_CompanyPostCode DOC_CompanyState
      DOC_CompanyTown DOC_DateIssued DOC_ExpiryDate SMC_Auditor
      SMC_DateIssued SMC_ExpiryDate ParallelRegister BareBoat_Charterer
      FlagStatusDecode ShipStatusDecode DateShipEnteredRegister
    )
  end

  private

  def build_results(vessels)
    vessels.uniq.sort_by(&:name).map do |vessel|
      assign_result(vessel)
    end
  end

   # rubocop:disable all
  def assign_result(vessel)
    owner = vessel.owners.first || Register::Owner.new
    manager = vessel.managers.first || Manager.new
    corporate_owner = vessel.owners.corporate.first || Register::Owner.new
    Result.new(
      [
        "GBI",
        vessel.imo_number,
        vessel.name,
        vessel.gross_tonnage,
        vessel.mmsi_number,
        WavesUtilities::Port.new(vessel.port_code).name,
        vessel.reg_no,
        vessel.radio_call_sign,
        "", # GrossTonnageFlagConvention
        vessel.net_tonnage,
        "", # NetTonnageFlagConvention
        "", # DeadWeight
        vessel.year_of_build,
        WavesDate.new(vessel.keel_laying_date).month_name,
        vessel.name_of_builder,
        vessel.country_of_build,
        vessel.vessel_category,
        vessel.vessel_type,
        owner.imo_number,
        owner.name,
        "", # RegOwnerNameLRFNamestyle
        owner.inline_address,
        corporate_owner.country,
        corporate_owner.date_of_incorporation,
        manager.imo_number,
        vessel.doc_auditor,
        manager.name,
        manager.country,
        "", # DOC_CompanyCountryRegistrationDecode
        "", # DOC_CompanyFoundedDate
        manager.inline_address,
        manager.postcode,
        manager.country,
        manager.town,
        "", # DOC_DateIssued
        "", # DOC_ExpiryDate
        vessel.smc_auditor,
        "", # SMC_DateIssued
        "", # SMC_ExpiryDate
        vessel.part.to_sym == :part_4 ? "YES" : "NO",
        vessel.charter_parties.map(&:name).join("; "),
        flag_status_decode(vessel), # FlagStatusDecode
        "", # ShipStatusDecode
        vessel.first_registration.try(:registered_at),
      ])
  end
  # rubocop:enable all

  def flag_status_decode(vessel)
    reg_status = vessel.registration_status.build_key

    if reg_status == :closed
      "Deleted" if vessel.current_registration.closed_at > 6.months.ago
    elsif Policies::Definitions.part_4?(vessel)
      "Parallel IN"
    elsif vessel.current_registration.try(:provisional?)
      "Provisional Register"
    elsif vessel.registration_status == :registered
      "Permanent Register"
    end
  end
end
