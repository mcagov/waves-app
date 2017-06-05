class LineItem < ApplicationRecord
  belongs_to :fee
  belongs_to :submission
end
