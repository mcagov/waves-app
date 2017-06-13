module Submission::Reporting
  class << self
    def included(base)
      base.scope :flag_in, -> { where(task: Task.flag_in) }
      base.scope :flag_out, -> { where(task:  Task.flag_out) }
      base.scope :merchant, -> {}
      base.scope :fishing, -> {}
      base.scope :under_15m, -> {}
      base.scope :between_15m_24m, -> {}
      base.scope :over_24m, -> {}
    end
  end
end
