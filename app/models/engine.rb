class Engine < ApplicationRecord
  belongs_to :parent, polymorphic: true
end
