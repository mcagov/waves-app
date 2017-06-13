module Submission::Reporting
  class << self
    # rubocop:disable all
    def included(base)
      base.scope :flag_in, -> { where(task: Task.flag_in) }
      base.scope :flag_out, -> { where(task:  Task.flag_out) }

      base.scope :merchant_vessels, (lambda do
        where(
          "(part = 'part_1') OR "\
          "(part = 'part_4' AND "\
          "changeset#>>'{vessel_info, registration_type}' != 'fishing')")
      end)

      base.scope :fishing_vessels, (lambda do
        where(
          "(part = 'part_2') OR "\
          "(part = 'part_4' AND "\
          "changeset#>>'{vessel_info, registration_type}' = 'fishing')")
      end)

      base.scope :under_15m, (lambda do
        where(
          "cast
            (coalesce(nullif(
              (changeset#>>'{vessel_info, register_length}'), ''), '0')
                as numeric) < 15.0")
      end)

      base.scope :between_15m_24m, (lambda do
        where(
          "cast
            (coalesce(nullif(
              (changeset#>>'{vessel_info, register_length}'), ''), '0')
                as numeric) between 15.0 and 24.0")
      end)

      base.scope :over_24m, (lambda do
        where(
          "cast
            (coalesce(nullif(
              (changeset#>>'{vessel_info, register_length}'), ''), '0')
                as numeric) > 24.0")
      end)
    end
    # rubocop:enable all
  end
end
