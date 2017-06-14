class Report::MaibVesselLength < Report
  def title
    "Fishing Vessel Length"
  end

  def headings
    ["Registered length", "No of vessels"]
  end

  REGISTER_LENGTHS =
    [
      "0.00 - 6.99",
      "7.00 - 7.99",
      "8.00 - 8.99",
      "9.00 - 9.99",
      "10.00 - 10.99",
      "11.00 - 11.99",
      "12.00 - 14.99",
      "15.00 - 16.49",
      "16.50 - 16.99",
      "17.00 - 17.99",
      "18.00 - 18.99",
      "19.00 - 19.99",
      "20.00 - 20.99",
      "21.00 - 21.99",
      "22.00 - 22.99",
      "23.00 - 23.99",
      "24.00 - 24.39",
      "24.40 - 44.49",
      "44.50 - 74.99",
      "75.00 - 99.99",
      "100.00 - "].freeze

  def results
    REGISTER_LENGTHS.map do |register_length|
      Result.new(
        [
          register_length,
          number_of_closures(register_length)])
    end
  end

  def number_of_closures(register_length)
    Registration
      .select("distinct vessel_id")
      .fishing_vessels
      .where("closed_at >= ?", @date_start)
      .where("closed_at <= ?", @date_end)
      .where(
        "#{Registration.register_length_finder} between ? and ?",
        length_min(register_length), length_max(register_length))
      .count
  end

  def length_min(register_length)
    register_length.split(" - ")[0].to_f
  end

  def length_max(register_length)
    (register_length.split(" - ")[1] || 9999999).to_f
  end
end
