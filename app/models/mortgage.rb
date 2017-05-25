class Mortgage < ApplicationRecord
  belongs_to :parent, polymorphic: true
  has_many :mortgagees, inverse_of: :mortgage, as: :parent, dependent: :destroy
  has_many :mortgagors, inverse_of: :mortgage, as: :parent, dependent: :destroy

  # rubocop:disable Style/AlignHash
  accepts_nested_attributes_for :mortgagees, allow_destroy: true,
    reject_if: proc { |attributes| attributes["name"].blank? }

  accepts_nested_attributes_for :mortgagors, allow_destroy: true,
    reject_if: proc { |attributes| attributes["name"].blank? }

  class << self
    def types_for(submission)
      if Task.new(submission.task).new_registration?
        %w(Intent)
      else
        ["Intent", "Account Current", "Principle Sum"]
      end
    end
  end
end
