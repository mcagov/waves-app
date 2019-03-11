class Report::FinanceBalance < Report
  def title
    "Finance Balance"
  end

  def headings
    [
      "Application ID",
      "Value of Incomplete",
      "Value of Underpayment",
      "Revenue Stream",
    ]
  end

  def results
    Submission.find_by_sql(submission_sql).map do |submission|
      incomplete, underpayment = balance_of(submission)

      Result.new(
        [submission.ref_no,
         RenderAsCurrency.new(incomplete),
         RenderAsCurrency.new(underpayment),
         submission.part.titleize])
    end
  end

  private

  def submission_sql # rubocop:disable Metrics/MethodLength
    <<-SQL
      SELECT s.ref_no, s.part,
      (COALESCE((SELECT SUM(p.amount) FROM payments p
           WHERE p.submission_id = s.id), 0)
       -
       COALESCE((SELECT SUM(t.price) FROM submission_tasks t
           WHERE t.submission_id = s.id AND t.state = 'completed'), 0))
      AS balance
      FROM submissions s WHERE s.state = 'active'
      AND
        (SELECT SUM(p.amount) FROM payments p WHERE p.submission_id = s.id)
          !=
        (SELECT SUM(t.price) FROM submission_tasks t
           WHERE t.submission_id = s.id
              AND t.state = 'completed')
      ORDER BY s.part, s.ref_no
    SQL
  end

  def balance_of(submission)
    if submission.balance > 0
      [submission.balance, 0]
    else
      [0, submission.balance]
    end
  end
end
