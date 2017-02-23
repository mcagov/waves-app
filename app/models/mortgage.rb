class Mortgage < ApplicationRecord
  belongs_to :parent, polymorphic: true
  has_many :mortgagees, inverse_of: :mortgage

  # rubocop:disable Style/AlignHash
  accepts_nested_attributes_for :mortgagees, allow_destroy: true,
    reject_if: proc { |attributes| attributes["name"].blank? }

  class << self
    def types_for(submission)
      if submission.task.to_sym == :new_registration
        %w(Intent)
      else
        ["Principle Sum", "Account Current"]
      end
    end
  end
end
