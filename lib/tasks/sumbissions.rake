namespace :submissions do

  task load: :environment do
    [
      "new_registration.json",
      "another_registration.json"
      ].
      each do |json_file_name|

        submission =
          NewRegistration.create(JSON.parse(
            File.read(Rails.root.join('spec', 'fixtures', json_file_name ))
          )["data"]["attributes"]
        )

        payment =
          Payment.new(JSON.parse(
            File.read(Rails.root.join('spec', 'fixtures', 'new_payment.json'))
          )["data"]["attributes"]
        )

        payment.submission_id = submission.id
        payment.save
      end
  end
end
