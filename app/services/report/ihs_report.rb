class Report::IhsReport < Report
  def title
    "IHS/Fairplay"
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
        .where("registrations.closed_at is null")
        .where("registrations.registered_until > ?", Date.today)
        .where(
          "(part = 'part_1') OR "\
          "(part = 'part_4' AND "\
          "registration_type != 'fishing')")
        .where("gross_tonnage > 100.0"))
  end

  def headings # rubocop:disable Metrics/MethodLength
    [
      "IMO number", "Vessel name", "GT", "MMSI", "Port of Registry",
      "Official Number", "Callsign", "Register tonnage", "Net Tonnage",
      "Register  Net Tonnage", "Deadweight", "Year of build", "Month of build",
      "Builder", "Country of build", "Ship Type.", "Ship Type Admin.",
      "Owner's IMO No.",  "Registered owner's name",
      "Registered owner's address", "Registered owner's country",
      "Registered owner date founded.", "IMO DOC Company Number",
      "IMO Company DOC auditor", "DOC Company name", "DOC Company Country",
      "DOC Company registration", "DOC Company founded date",
      "DOC Company full address", "DOC Company Postcode", "DOC Company State",
      "DOC Company Town", "DOC date issued", "DOC expiry date.",
      "SMC Auditor", " SMC date issued", "SMC Expiry date", "Parallel register",
      "Bareboat Charterer", "Flag status", "Ship status",
      "Date ship entered register."
    ]
  end

  private

  def build_results(vessels)
    vessels.uniq.sort_by(&:name).map do |vessel|
      assign_result(vessel)
    end
  end

   # rubocop:disable all
  def assign_result(vessel)
    owner = vessel.owners.first || Owner.new
    manager = vessel.managers.first || Manager.new
    Result.new(
      [
        vessel.imo_number,
        vessel.name,
        vessel.gross_tonnage,
        vessel.mmsi_number,
        WavesUtilities::Port.new(vessel.port_code).name,
        vessel.reg_no,
        vessel.radio_call_sign,
        vessel.register_tonnage,
        vessel.net_tonnage,
        "", # Register  Net Tonnage
        "", # Deadweight
        vessel.year_of_build,
        WavesDate.new(vessel.keel_laying_date).month_name,
        vessel.name_of_builder,
        vessel.country_of_build,
        vessel.vessel_category,
        vessel.vessel_type,
        owner.imo_number,
        owner.name,
        owner.inline_address,
        owner.country,
        owner.date_of_incorporation,
        manager.imo_number,
        vessel.doc_auditor,
        manager.name,
        manager.country,
        "", # DOC Company registration
        "", # DOC Company founded date
        manager.inline_address,
        manager.postcode,
        "", # DOC Company State
        "", # DOC Company Town
        "", # DOC date issued
        "", # DOC expiry date.
        vessel.smc_auditor,
        "", # SMC date issued
        "", # SMC Expiry date
        vessel.part.to_sym == :part_4 ? "YES" : "NO",
        vessel.charter_parties.map(&:name).join("; "),
        "", # Flag status
        "", # Ship status
        vessel.first_registration.try(:registered_at),
      ])
  end
  # rubocop:enable all
end
