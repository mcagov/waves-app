class Search
  class << self
    def by_vessel(part, q)
      Register::Vessel.where(reg_no: q, part: part.to_s)
    end

    def by_submission(part, q)
      Submission.where(ref_no: q, part: part.to_s)
    end

    def similar_vessels(part, vessel)
      Register::Vessel
        .where(name: vessel.name, part: part.to_s)
        .or(Register::Vessel
          .where(["hin = ? and hin <> ''", vessel.hin]))
        .or(Register::Vessel
            .where(["mmsi_number = ? and mmsi_number > 0",
                    vessel.mmsi_number.to_i]))
        .or(Register::Vessel
          .where(["radio_call_sign = ? and radio_call_sign <> ''",
                  vessel.radio_call_sign]))
    end
  end
end
