module RegistrationHelpers
  def create_registration!
    new_registration_json = JSON.parse(File.read('spec/fixtures/new_registration.json'))
    Registration.create(new_registration_json["data"]["attributes"])
  end

  def create_paid_registration!
    registration = create_registration!

    new_payment_json = JSON.parse(File.read('spec/fixtures/new_payment.json'))
    payment = Payment.new(new_payment_json["data"]["attributes"])

    payment.registration_id = registration.id
    payment.save

    registration
  end
end
