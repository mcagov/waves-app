u = User.find_or_initialize_by(name: "Toby Privett")
u.email = "toby@snaplab.co.uk"
u.password = "password"
u.access_level = :system_manager
u.save!

Service.delete_all

Service.create(
  name: "New Registration",
  position: 10,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 153, premium: 180 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 153, premium: 180 },
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
  position: 20,
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 196, premium: 180 },
  part_4: { standard: 196, premium: 180 },
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
  position: 30,
  standard_days: 10,
  part_2: { standard: 159 },
  part_4: { standard: 159 },
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
  position: 40,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 175, premium: 140 },
  part_4: { standard: 175, premium: 140 },
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
  position: 50,
  standard_days: 3,
  premium_days: 1,
  part_2: { standard: 179, premium: 140 },
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
  position: 60,
  standard_days: 3,
  part_2: { standard: 155 },
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
  position: 70,
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 88, premium: 100 },
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
  position: 80,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 75, premium: 50 },
  part_2: { standard: 75, premium: 50 },
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
  position: 90,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 72, premium: 100 },
  part_2: { standard: 70, premium: 100 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 72, premium: 100 },
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
  position: 100,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 153, premium: 180 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 153, premium: 180 },
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
  position: 110,
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 196, premium: 180 },
  part_4: { standard: 196, premium: 180 },
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
  position: 120,
  standard_days: 10,
  part_2: { standard: 159 },
  part_4: { standard: 159 },
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
  position: 130,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 105, premium: 100, subsequent: 20 },
  part_2: { standard: 105, premium: 100, subsequent: 21 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 105, premium: 100, subsequent: 21 },
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
  position: 140,
  standard_days: 10,
  premium_days: 1,
  part_2: { standard: 88, premium: 100, subsequent: 21 },
  part_4: { standard: 88, premium: 100, subsequent: 21 },
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
  position: 150,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 46, premium: 100, subsequent: 17 },
  part_2: { standard: 53, premium: 100, subsequent: 17 },
  part_4: { standard: 46, premium: 100, subsequent: 17 },
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
  position: 160,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 46, premium: 100 },
  part_2: { standard: 53, premium: 100 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 46, premium: 100 },
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
  position: 170,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 29, premium: 50 },
  part_2: { standard: 32, premium: 50 },
  part_3: { standard: 29, premium: 50 },
  part_4: { standard: 29, premium: 50 },
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
  position: 180,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 46, premium: 50 },
  part_2: { standard: 46, premium: 50 },
  part_3: { standard: 46, premium: 50 },
  part_4: { standard: 46, premium: 50 },
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
  position: 190,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 32, premium: 50 },
  part_2: { standard: 32, premium: 50 },
  part_3: { standard: 35, premium: 50 },
  part_4: { standard: 32, premium: 50 },
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
  position: 200,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 37, premium: 50 },
  part_2: { standard: 37, premium: 50 },
  rules: [
  ],
  activities: [
  ])

Service.create(
  name: "Mortgage registration",
  position: 210,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 101, premium: 100, subsequent: 19 },
  part_2: { standard: 101, premium: 100, subsequent: 13 },
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
  position: 220,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 135, premium: 100 },
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
  position: 230,
  standard_days: 3,
  premium_days: 1,
  part_1: { standard: 52, premium: 100 },
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
  position: 240,
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
  position: 250,
  standard_days: 10,
  premium_days: 1,
  part_1: { standard: 15, premium: 50 },
  part_2: { standard: 15, premium: 50 },
  part_3: { standard: 15, premium: 50 },
  part_4: { standard: 15, premium: 50 },
  rules: [
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
  ])

Service.create(
  name: "Change of address",
  position: 260,
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
  position: 270,
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
  position: 280,
  standard_days: 10,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
  ],
  activities: [
    :update_registry_details,
  ],
  print_templates: [
  ])

Service.create(
  name: "Mortgage discharge",
  position: 290,
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
  position: 300,
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
  position: 310,
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
  position: 320,
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
  position: 330,
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
  position: 340,
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
  position: 350,
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
  position: 360,
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
  position: 370,
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

Service.create(
  name: "Write on",
  position: 380,
  standard_days: 1,
  part_1: { standard: 0 },
  part_2: { standard: 0 },
  part_3: { standard: 0 },
  part_4: { standard: 0 },
  rules: [
    :registry_not_editable,
  ],
  activities: [
  ],
  print_templates: [
  ])
