namespace :submissions do
  task load: :environment do
    [
      "new_registration.json",
      "another_registration.json",
    ].each do |json_file_name|

      submission =
        Submission.create(
          JSON.parse(
            File.read(Rails.root.join("spec", "fixtures", json_file_name))
          )["data"]["attributes"]
        )

      payment_params =
        JSON.parse(
          File.read(Rails.root.join("spec", "fixtures", "new_payment.json"))
        )["data"]["attributes"]

      payment_params[:submission_id] = submission.id

      payment =
        Builders::WorldPayPaymentBuilder.create(
          payment_params.to_h.symbolize_keys)

      payment.save
    end
  end
end
