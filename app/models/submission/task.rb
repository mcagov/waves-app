class Submission::Task < ApplicationRecord
  belongs_to :service
  belongs_to :submission
  delegate :to_sym, to: :service
end
