class Mortgage < ApplicationRecord
  belongs_to :parent, polymorphic: true
end
