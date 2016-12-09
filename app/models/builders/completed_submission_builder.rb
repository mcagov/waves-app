module Builders
  class CompletedSubmissionBuilder < AssignedSubmissionBuilder
    class << self
      def current_state
        :completed
      end
    end
  end
end
