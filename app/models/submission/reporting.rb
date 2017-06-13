module Submission::Reporting
  class << self
    def included(base) # rubocop:disable Metrics/MethodLength
      base.scope :flag_in, -> { where(task: Task.flag_in) }
      base.scope :flag_out, -> { where(task:  Task.flag_out) }

      base.scope :merchant, -> {}
      base.scope :fishing, -> {}

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
  end
end
