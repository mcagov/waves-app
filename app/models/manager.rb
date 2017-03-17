class Manager < Customer
  has_one :safety_management, as: :parent, dependent: :destroy

  accepts_nested_attributes_for(
    :safety_management,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes["address_1"].blank? })
end
