class Mortgagor < Customer
  belongs_to :mortgage,
             inverse_of: :mortgagors,
             foreign_key: :parent_id,
             foreign_type: :parent_id

  attr_accessor :declaration_owner_id

  private

  before_save :check_declaration_owner_id

  def check_declaration_owner_id
    return unless declaration_owner_id.present?
    owner = Declaration.find(declaration_owner_id).owner
    self.name = owner.name
    self.address_1 = owner.address_1
    self.address_2 = owner.address_2
    self.address_3 = owner.address_3
    self.town = owner.town
    self.postcode = owner.postcode
    self.country = owner.country
  end
end
