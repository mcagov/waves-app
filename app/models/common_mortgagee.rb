class CommonMortgagee < Customer
  def formatted_id
    [
      name,
      address_1,
      address_2,
      address_3,
      town,
      country,
      postcode,
    ].join(";")
  end
end
