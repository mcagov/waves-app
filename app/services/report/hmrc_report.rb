class Report::HmrcReport < Report
  def title
    "6 - 6.99m"
  end

  def second_sheet_title
    "Over 7m"
  end

  def third_sheet_title
    "New Registrations"
  end

  def results
    build_results(
      registered_part_2_fishing_vessels
      .where("vessels.length_overall BETWEEN 6.0 AND 6.99").uniq)
  end

  def second_sheet_results
    build_results(
      registered_part_2_fishing_vessels
      .where("vessels.length_overall > 6.99").uniq)
  end

  def third_sheet_results
    build_results(
      Submission
        .in_part(:part_2)
        .includes(
          reportable_registered_vessel:
            [:owners, :engines, :latest_completed_submission])
        .flag_in
        .where("completed_at >= ?", @date_start)
        .where("completed_at <= ?", @date_end)
        .map(&:reportable_registered_vessel))
  end

  def headings
    [
      "Vessel name", "PLN", "Official number", "Registered length",
      "Overall length", "Depth", "Breadth", "GT", "Registered Tonnage",
      "MCEP", "Construction material", "Year of build", "Place of build",
      "Last task type performed for the vessel",
      "Date of last task completed", "Type of fishing vessel",
      "Owner name and address"
    ]
  end

  private

  def registered_part_2_fishing_vessels
    Register::Vessel
      .in_part(:part_2)
      .joins(:current_registration)
      .includes([:owners, :engines, :latest_completed_submission])
      .where("vessels.frozen_at is null")
      .where("registrations.closed_at is null")
      .where("registrations.registered_until > ?", Date.today)
  end

  def build_results(vessels)
    vessels.sort_by(&:pln).map do |vessel|
      assign_result(vessel)
    end
  end

  # rubocop:disable all
  def assign_result(vessel)
    submission = vessel.latest_completed_submission
    task_description = submission ? Task.new(submission.task).description : ""

    Result.new(
      [
        vessel.name,
        vessel.pln,
        vessel.reg_no,
        vessel.register_length,
        vessel.length_overall,
        vessel.depth,
        vessel.breadth,
        vessel.gross_tonnage,
        vessel.register_tonnage,
        "Engine.total_mcep_for(vessel)",
        vessel.hull_construction_material,
        vessel.year_of_build,
        vessel.place_of_build,
        task_description,
        submission.try(:completed_at),
        vessel.vessel_type,
        vessel.owners.map(&:inline_name_and_address).join("; "),
      ])
  end
  # rubocop:enable all
end
