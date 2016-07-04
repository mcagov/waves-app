class Declaration
  include ActiveModel::Model

  attr_accessor(
    :eligible_under_regulation_89,
    :eligible_under_regulation_90,
    :understands_false_statement_is_offence
  )

  validates :eligible_under_regulation_89, acceptance: true
  validates :eligible_under_regulation_90, acceptance: true
  validates :understands_false_statement_is_offence, acceptance: true
end
