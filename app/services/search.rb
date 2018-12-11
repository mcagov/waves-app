class Search
  class << self
    def submissions(term, part = nil)
      term = RefNo.parse(term)
      submissions = PgSearch.multisearch(term)
                            .where(searchable_type: "Submission")
                            .includes(searchable: [declarations: :owner])
      submissions = submissions_in_part(submissions, part)
      submissions.limit(50).map(&:searchable)
    end

    def vessels(term, part = nil)
      vessels = PgSearch.multisearch(term)
                        .where(searchable_type: "Register::Vessel")
                        .includes(searchable: [:owners, :submissions])
      vessels = vessels_in_part(vessels, part)
      vessels.limit(50).map(&:searchable)
    end

    def finance_payments(params) # rubocop:disable Metrics/MethodLength
      fp =
        PgSearch.multisearch(params[:term])
                .joins(
                  "LEFT JOIN finance_payments ON (finance_payments.id =
                  pg_search_documents.searchable_id)")
                .where(searchable_type: "Payment::FinancePayment")
                .includes(searchable: [:batch, payment: [:submission]])
      fp = finance_payments_in_part(fp, params[:part])
      fp = finance_payments_date_start(fp, params[:date_start])
      fp = finance_payments_date_end(fp, params[:date_end])
      fp.limit(100).map(&:searchable)
    end

    # looks for similar vessels, to help
    # a reg officer on a part_3 application page
    def similar_vessels(part, vessel) # rubocop:disable Metrics/MethodLength
      Register::Vessel
        .in_part(part)
        .where(name: vessel.name)
        .or(Register::Vessel
          .where(["hin = ? and hin <> ''", vessel.hin]))
        .or(Register::Vessel
            .where(["mmsi_number = ? and mmsi_number <> ''",
                    vessel.mmsi_number]))
        .or(Register::Vessel
          .where(["radio_call_sign = ? and radio_call_sign <> ''",
                  vessel.radio_call_sign]))
    end

    private

    def vessels_in_part(arel, part)
      return arel unless part

      arel.joins("LEFT JOIN vessels ON (vessels.id =
                 pg_search_documents.searchable_id)"
                ).where("vessels.part = ?", part)
    end

    def submissions_in_part(arel, part)
      return arel unless part

      arel.joins("LEFT JOIN submissions ON (submissions.id =
                 pg_search_documents.searchable_id)"
                ).where("submissions.part = ?", part)
    end

    def finance_payments_in_part(arel, part)
      return arel unless part.present?

      arel.where("finance_payments.part = ?", part)
    end

    def finance_payments_date_start(arel, date_start)
      return arel unless date_start.present?

      arel.where("finance_payments.payment_date >= ?", date_start.to_date)
    end

    def finance_payments_date_end(arel, date_end)
      return arel unless date_end.present?

      arel.where("finance_payments.payment_date <= ?", date_end.to_date)
    end
  end
end
