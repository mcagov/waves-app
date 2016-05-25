module RegistrationsMixin
  def prerequisites_parameters_hash(value = "0")
    {
      not_registered_before_on_ssr: value,
      not_registered_under_part_1: value,
      not_owned_by_company: value,
      not_commercial_fishing_or_submersible: value,
      owners_are_uk_residents: value,
      owners_are_eligible_to_register: value,
      not_registered_on_foreign_registry: value,
    }
  end

  def declaration_parameters_hash(value = "0")
    {
      eligible_under_regulation_89: value,
      eligible_under_regulation_90: value,
      understands_false_statement_is_offence: value,
    }
  end

  def valid_parameters_for(what)
    case what
    when :prerequisites
      prerequisites_parameters_hash("1")
    when :declaration
      declaration_parameters_hash("1").merge(
        prerequisites_parameters_hash("1")
      )
    end
  end

  def invalid_parameters_for(what)
    case what
    when :prerequisites
      prerequisites_parameters_hash
    when :declaration
      declaration_parameters_hash.merge(
        prerequisites_parameters_hash("1")
      )
    end
  end
end
