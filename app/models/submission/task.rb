class Submission::Task < ApplicationRecord
  belongs_to :service
  delegate :to_sym, to: :service
end
