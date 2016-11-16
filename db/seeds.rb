# rubocop:disable all
USERS = %w(alice bob charlie develop).freeze

USERS.each do |user|
  u = User.find_or_initialize_by(name: user.humanize)
  u.email = "#{user}@example.com"
  u.name = "#{user.titleize} Waves"
  u.password = "password"
  u.save! if u.valid?
end

10.times do
  vessel = Register::Vessel.create(
    part: :part_3,
    name: Faker::Beer.name,
    hin: "GB-#{[*("0".."9"), *("A".."Z")].sample(12).join}",
    mmsi_number:"#{rand(232..235)}#{rand.to_s[2..7]}",
    radio_call_sign: "#{[*("0".."9"), *("A".."Z")].sample(6).join}",
    make_and_model: Faker::Beer.style,
    number_of_hulls: rand(1..6),
    length_in_meters: rand(1..23),
    vessel_type: WavesUtilities::VesselType.all.sample
  )

  rand(1..4).times do
    vessel.owners.create(
      name: Faker::Name.name,
      email: Faker::Internet.safe_email,
      nationality: WavesUtilities::Nationality.all.sample,
      phone_number: Faker::PhoneNumber.phone_number,
      address_1: Faker::Address.street_address.upcase,
      address_2: Faker::Address.street_name.upcase,
      address_3: nil,
      town: Faker::Address.city.upcase,
      postcode: Faker::Address.postcode.upcase,
      country: "UNITED KINGDOM"
    )
  end

  registered_at = Faker::Date.between(4.years.ago, 1.month.ago)
  vessel.registrations.create(
    registered_at: registered_at,
    registered_until: registered_at.advance(years: 5)
  )
end

2.times do
  Task.default_task_types.reject do |task|
     [:new_registration].include?(task[1])
  end.each do |task|

    submission = Submission.create!(
      part: :part_3,
      source: :online,
      task: task[1],
      registered_vessel_id: Register::Vessel.all.sample.id
    )

    submission.payments.create(
      amount: 2500,
      remittance: Payment::WorldPay.new
    )

    submission.declarations.map(&:declared!)
  end
end
# rubocop:enable all
