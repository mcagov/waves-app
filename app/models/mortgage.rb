class Mortgage < ApplicationRecord
  belongs_to :parent, polymorphic: true

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
