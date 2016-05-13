module PreregistrationsMixin
  def preregistration_parameters_hash(value = "0")
    {
      not_registered_before_on_ssr: value,
      not_registered_under_part_1: value,
      owners_are_uk_residents: value,
      user_eligible_to_register: value
    }
  end

  def valid_parameters
    preregistration_parameters_hash("1")
  end

  def invalid_parameters
    preregistration_parameters_hash
  end
end
