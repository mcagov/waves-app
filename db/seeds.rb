u = User.find_or_initialize_by(name: "Toby Privett")
u.email = "toby@snaplab.co.uk"
u.password = "password"
u.access_level = :system_manager
u.save!

Service.delete_all

Service.create(
  name: "New Registration",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 124, premium: 180 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 124, premium: 180 },
  rules: [
    :validates_on_approval,
    :declarations_required,
    :carving_and_marking_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "New Registration - full",
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 131, premium: 180 },
  part_4: { standard: 131, premium: 180 },
  rules: [
    :validates_on_approval,
    :declarations_required,
    :carving_and_marking_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "New Registration - simple",
  standard_days: 10,
  part_2: { standard: 111 },
  part_4: { standard: 131, premium: 180 },
  rules: [
    :validates_on_approval,
    :declarations_required,
    :carving_and_marking_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Provisional Registration",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 117, premium: 140 },
  rules: [
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_provisional_registration,
    :update_registry_details,
  ],
  print_templates: [
    :provisional_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Provisional Registration - full",
  standard_days: 3,
  premium_days: 1,
  part_2: { standard: 122, premium: 140 },
  rules: [
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_provisional_registration,
    :update_registry_details,
  ],
  print_templates: [
    :provisional_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Provisional Registration - simple",
  standard_days: 3,
  part_2: { standard: 122 },
  rules: [
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_provisional_registration,
    :update_registry_details,
  ],
  print_templates: [
    :provisional_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Convert simple to full registration",
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 61, premium: 100 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Convert provisional to full",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 55, premium: 50 },
  part_2: { standard: 55, premium: 50 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :carving_and_marking_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Renewal",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 49, premium: 100 },
  part_2: { standard: 49, premium: 100 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 49, premium: 100 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Re-registration",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 124, premium: 180 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 124, premium: 180 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Re-registration - full",
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 131, premium: 180 },
  part_4: { standard: 131, premium: 180 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Re-registration - simple",
  standard_days: 10,
  part_2: { standard: 111 },
  part_4: { standard: 111 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :declarations_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Change of ownership (full)",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 80, premium: 100, subsequent: 15 },
  part_2: { standard: 80, premium: 100, subsequent: 15 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 80, premium: 100, subsequent: 15 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :declarations_required,
    :prompt_if_registered_mortgage,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Change of ownership - simple",
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 63, premium: 100, subsequent: 15 },
  part_4: { standard: 63, premium: 100, subsequent: 15 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Change of name/port/tonnage (1&4)",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 37, premium: 100, subsequent: 17 },
  part_2: { standard: 37, premium: 100, subsequent: 17 },
  part_4: { standard: 37, premium: 100, subsequent: 17 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
    :carving_and_marking_required,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Change of vessel details",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 37, premium: 100, subsequent: 17 },
  part_2: { standard: 37, premium: 100, subsequent: 17 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 37, premium: 100, subsequent: 17 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Current transcript",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 21, premium: 50 },
  part_2: { standard: 21, premium: 50 },
  part_3: { standard: 21, premium: 50 },
  part_4: { standard: 21, premium: 50 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
    :current_transcript,
  ])

Service.create(
  name: "Historic transcript",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 32, premium: 50 },
  part_2: { standard: 32, premium: 50 },
  part_3: { standard: 32, premium: 50 },
  part_4: { standard: 32, premium: 50 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
    :historic_transcript,
  ])

Service.create(
  name: "Duplicate certificate",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 21, premium: 50 },
  part_2: { standard: 21, premium: 50 },
  part_3: { standard: 25, premium: 50 },
  part_4: { standard: 21, premium: 50 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
    :duplicate_registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Mortgage intent",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 25, premium: 50 },
  part_2: { standard: 25, premium: 50 },
  rules: [
  ],
  activities: [
  ])

Service.create(
  name: "Mortgage registration",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 84, premium: 100, subsequent: 15 },
  part_2: { standard: 84, premium: 100, subsequent: 15 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ])

Service.create(
  name: "Transfer in",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 115, premium: 50 },
  rules: [
    :validates_on_approval,
    :declarations_required,
    :carving_and_marking_required,
  ],
  activities: [
    :generate_new_5_year_registration,
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Transfer out",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 35, premium: 100 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
    :close_registration,
  ],
  print_templates: [
    :current_transcript,
    :cover_letter,
  ])

Service.create(
  name: "Courier/postage fee (allocate funds, no processing)",
  standard_days: 10,
  part_1: { standard: 30 },
  part_2: { standard: 30 },
  part_3: { standard: 30 },
  part_4: { standard: 30 },
  rules: [
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
  ])

Service.create(
  name: "Copy of a document relating to a registration",
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 13, premium: 50 },
  part_2: { standard: 13, premium: 50 },
  part_3: { standard: 13, premium: 50 },
  part_4: { standard: 13, premium: 50 },
  rules: [
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
  ])

Service.create(
  name: "Change of address",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
    :registration_certificate,
    :cover_letter,
  ])

Service.create(
  name: "Change of address (Part 3)",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
  ])

Service.create(
  name: "General Enquiry/other non-fee task",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
  ])

Service.create(
  name: "Mortgage discharge",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  rules: [
    :registered_vessel_required,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
  ])

Service.create(
  name: "Mortgage transfer",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :validates_on_approval,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
  ])

Service.create(
  name: "Registration Closure",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
    :close_registration,
  ],
  print_templates: [
    :current_transcript,
  ])

Service.create(
  name: "Carving and marking receipt",
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 0, premium: 0 },
  part_2: { standard: 0, premium: 0 },
  part_4: { standard: 0, premium: 0 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
  ])

Service.create(
  name: "Issue CSR",
  standard_days: 3,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :issues_csr,
  ],
  activities: [
    :issue_csr,
  ],
  print_templates: [
    :csr_form,
  ])

Service.create(
  name: "Manual Override",
  standard_days: 1,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :not_referrable,
  ],
  activities: [
    :update_registry_details,
    :record_transcript_event,
  ],
  print_templates: [
  ])

Service.create(
  name: "Registration Closure: Owner Request",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
    :close_registration,
  ],
  print_templates: [
    :current_transcript,
  ])

Service.create(
  name: "Registration Closure: Close Without Notice",
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [
    :close_registration,
  ],
  print_templates: [
    :current_transcript,
    :forced_closure,
  ])

Service.create(
  name: "Restore Closed Registration",
  standard_days: 1,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registered_vessel_required,
    :registry_not_editable,
  ],
  activities: [:restore_closure],
  print_templates: [
  ])
