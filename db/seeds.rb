# USERS = [
#   ["toby.privett@oceanshq.com", "Toby Privett", 3],
#   ["andre.tanguy@oceanshq.com", "Andre Tanguy", 3],
#   ["Laura.Clark-Theobald@mcga.gov.uk", "Laura Clark-Theobald", 3],
#   ["Rachel.Miles@mcga.gov.uk", "Rachel Miles", 3],
#   ["Ugo.Ottanelli@mcga.gov.uk", "Ugo Ottanelli", 3],
#   ["Charlotte.Clarke@mcga.gov.uk", "Charlotte Clarke", 3],
#   ["Adam.Wheal@mcga.gov.uk", "Adam Wheal", 3],
# ].freeze

# USERS.each do |user|
#   u = User.find_or_initialize_by(name: user[1])
#   u.email = user[0]
#   u.name = user[1]
#   u.password = Devise.friendly_token.first(8)
#   u.access_level = user[2]
#   u.save! if u.valid?
# end

Fee.delete_all

FEES = [
  [:part_1_new_registration, :new_registration, 12400, 18000],
  [:part_2_simple_new_registration, :new_registration, 11100, nil],
  [:part_2_full_new_registration, :new_registration, 13100, 18000],
  [:part_3_new_registration, :new_registration, 2500, 5000],
  [:part_4_new_registration, :new_registration, 12400, 18000],

  [:part_1_provisional, :provisional_registration, 11700, 14000],
  [:part_2_simple_provisional, :provisional_registration, 10500, 14000],
  [:part_2_full_provisional, :provisional_registration, 12200, 14000],

  [:part_1_new_registration, :transfer_from_bdt, 11500, 10000],
  [:part_1_transfer_to_bdt, :transfer_to_bdt, 3500, 10000],
  [:part_1_closure, :transfer_to_bdt, 3500, 10000],

  [:part_1_renewal, :renewal, 4900, 10000],
  [:part_2_simple_renewal, :renewal, 4900, 10000],
  [:part_2_full_renewal, :renewal, 4900, 10000],
  [:part_3_renewal, :renewal, 2500, 5000],
  [:part_4_renewal, :renewal, 4900, 10000],

  [:part_1_re_registration, :re_registration, 12400, 18000],
  [:part_2_simple_re_registration, :re_registration, 11100, nil],
  [:part_2_full_re_registration, :re_registration, 13100, 18000],
  [:part_3_registration, :re_registration, 2500, 5000],

  [:part_1_change_vessel, :convert_pleasure_to_or_from_commercial, 3700, 10000],
  [:part_1_change_vessel, :convert_provisional_to_full, 5500, 5000],

  [:part_2_simple_change_vessel, :convert_provisional_to_simple, 5500, 5000],
  [:part_2_full_change_vessel, :convert_provisional_to_full, 5500, 5000],

  # Note, we would expect a "convert to full" to be implemented for a submission
  # where the registration type has already been set to "full". But it might
  # still be set as "simple", so we need to ensure this task will appear for
  # all part_2 submissions.
  [:part_2_simple_change_vessel, :convert_simple_to_full, 6100, 10000],
  [:part_2_full_change_vessel, :convert_provisional_to_full, 5500, 5000],

  # To add to the confusion, we also have a task "simple_to_full"
  [:part_2_simple_simple_to_full, :convert_simple_to_full, 6100, 10000],
  [:part_2_full_simple_to_full, :convert_simple_to_full, 6100, 10000],

  [:part_1_change_owner, :change_owner, 8000, 10000, 1500],
  [:part_2_simple_change_owner, :change_owner, 6300, 10000, 1500],
  [:part_2_full_change_owner, :change_owner, 8000, 10000, 1500],
  [:part_3_change_owner, :change_owner, 2500, 5000],
  [:part_4_change_owner, :change_owner, 8000, 10000],

  [:part_1_change_vessel, :change_vessel, 3700, 10000, 1700],
  [:part_2_simple_change_vessel, :change_vessel, 3700, 10000, 1700],
  [:part_2_full_change_vessel, :change_vessel, 3700, 10000, 1700],
  [:part_3_change_vessel, :change_vessel, 2500, 5000],
  [:part_4_change_vessel, :change_vessel, 3700, 10000, 1700],

  [:part_1_mortgage, :mortgage, 8400, 10000, 1500],
  [:part_2_full_mortgage, :mortgage, 8400, 10000, 1500],

  [:part_1_mortgage, :mortgage_intent, 2500, 5000, 5000],
  [:part_1_new_registration, :mortgage_intent, 2500, 5000, 5000],
  [:part_1_re_registration, :mortgage_intent, 2500, 5000, 5000],

  [:part_2_full_mortgage, :mortgage_intent, 2500, 5000, 5000],
  [:part_2_full_new_registration, :mortgage_intent, 2500, 5000, 5000],
  [:part_2_full_re_registration, :mortgage_intent, 2500, 5000, 5000],

  [:part_1_current_transcript, :current_transcript, 2100, 5000],
  [:part_2_simple_current_transcript, :current_transcript, 2100, 5000],
  [:part_2_full_current_transcript, :current_transcript, 2100, 5000],
  [:part_3_current_transcript, :current_transcript, 2500, 5000],
  [:part_4_current_transcript, :current_transcript, 2100, 5000],

  [:part_1_historic_transcript, :historic_transcript, 3200, 5000],
  [:part_2_simple_historic_transcript, :historic_transcript, 3200, 5000],
  [:part_2_full_historic_transcript, :historic_transcript, 3200, 5000],
  [:part_3_historic_transcript, :historic_transcript, 2500, 5000],
  [:part_4_historic_transcript, :historic_transcript, 3200, 5000],

  [:part_1_issue_csr, :issue_csr, 2100, 5000],
  [:part_2_full_issue_csr, :issue_csr, 2100, 5000],
  [:part_4_issue_csr, :issue_csr, 2100, 5000],

  [:part_1_csr_certified_copy, :csr_certified_copy, 3200, 5000],
  [:part_2_full_csr_certified_copy, :csr_certified_copy, 3200, 5000],
  [:part_4_csr_certified_copy, :csr_certified_copy, 3200, 5000],

  [:part_1_duplicate_certificate, :duplicate_certificate, 2100, 5000],
  [:part_2_simple_duplicate_certificate, :duplicate_certificate, 2100, 5000],
  [:part_2_full_duplicate_certificate, :duplicate_certificate, 2100, 5000],
  [:part_3_duplicate_certificate, :duplicate_certificate, 2100, 5000],
  [:part_4_duplicate_certificate, :duplicate_certificate, 2100, 5000],

  [:all_parts, :copy_of_document, 1300, 5000, 1300],
  [:all_parts, :certificate_of_non_registry, 1300],
].freeze

FEES.each do |seed|
  Fee.create(
    category: seed[0],
    task_variant: seed[1],
    price: seed[2],
    premium_addon_price: seed[3],
    subsequent_price: seed[4])
end
