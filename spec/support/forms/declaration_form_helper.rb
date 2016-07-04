def default_declaration_form_fields
  {
    eligible_under_regulation_89: true,
    eligible_under_regulation_90: true,
    understands_false_statement_is_offence: true,
  }.freeze
end

def complete_declaration_form(fields = default_declaration_form_fields)
  fill_form_and_submit(:declaration, :update, fields)
end
