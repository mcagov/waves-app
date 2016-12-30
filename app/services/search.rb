class Search
  class << self
    def all(term)
      PgSearch.multisearch(term)
    end

    # rubocop:disable Metrics/MethodLength
    def similar_vessels(part, vessel)
      Register::Vessel
        .in_part(part)
        .where(name: vessel.name)
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
