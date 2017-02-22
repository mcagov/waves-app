class Mortgage < ApplicationRecord
  belongs_to :parent, polymorphic: true

  class << self
    def types_for(_submission)
      %w{Intent}
    end
  end
end
