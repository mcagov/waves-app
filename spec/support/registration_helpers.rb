module RegistrationHelpers
  def create_registration!
    new_registration_json = JSON.parse(File.read('spec/fixtures/new_registration.json'))
    Registration.create(new_registration_json["data"]["attributes"])
  end
end
