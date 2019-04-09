class Anonymizer
  ANON = "<removed>".freeze

  def initialize(registered_vessel, user)
    @registered_vessel = registered_vessel
    @user = user
  end

  def perform
    customers_table
    finance_payments_table
    submissions_table
    registrations_table
    submission_documents
    vessel_documents
    notifications_table
    @registered_vessel.update(scrubbed_at: Time.zone.now)
    @registered_vessel.update(scrubbed_by: @user)
  end

  private

  def customers_table
    attrs = { email: ANON, phone_number: ANON }

    @registered_vessel.customers.each { |c| c.update_attributes(attrs) }

    @registered_vessel.submissions.each do |submission|
      submission.beneficial_owners.each { |c| c.update_attributes(attrs) }
      submission.directed_bys.each { |c| c.update_attributes(attrs) }
      submission.managed_bys.each { |c| c.update_attributes(attrs) }
      submission.managers.each { |c| c.update_attributes(attrs) }
      submission.charter_parties.each { |c| c.update_attributes(attrs) }
    end
  end

  def finance_payments_table
    @registered_vessel.submissions.each do |submission|
      submission.payments.each do |payment|
        next unless payment.remittance.is_a?(Payment::FinancePayment)
        payment.remittance.update_attributes(
          applicant_email: ANON,
          applicant_name: ANON,
          payer_name: ANON,
          payment_reference: ANON)
      end
    end
  end

  def submissions_table # rubocop:disable Metrics/MethodLength
    attrs = { email: ANON, phone_number: ANON }

    @registered_vessel.submissions.each do |submission|
      submission.update_attributes(applicant_email: ANON)
      submission.owners.each { |c| c.update_attributes(attrs) }

      if submission.changeset[:agent]
        submission.changeset[:agent][:email] = ANON
        submission.changeset[:agent][:phone_number] = ANON
      end

      if submission.changeset[:representative]
        submission.changeset[:representative][:email] = ANON
        submission.changeset[:representative][:phone_number] = ANON
      end

      submission.save(validation: false)
    end
  end

  # rubocop:disable all
  def registrations_table
    @registered_vessel.registrations.each do |registration|
      registration.registry_info.deep_symbolize_keys!

      (registration.registry_info[:owners] || []).each do |c|
        c[:email] = ANON
        c[:phone_number] = ANON
      end

      if registration.registry_info[:agent]
        registration.registry_info[:agent][:email] = ANON
        registration.registry_info[:agent][:phone_number] = ANON
      end

      if registration.registry_info[:representative]
        registration.registry_info[:representative][:email] = ANON
        registration.registry_info[:representative][:phone_number] = ANON
      end

      (registration.registry_info[:beneficial_owners] || []).each do |c|
        c[:email] = ANON
        c[:phone_number] = ANON
      end
      (registration.registry_info[:directed_bys] || []).each do |c|
        c[:email] = ANON
        c[:phone_number] = ANON
      end
      (registration.registry_info[:managed_bys] || []).each do |c|
        c[:email] = ANON
        c[:phone_number] = ANON
      end
      (registration.registry_info[:managers] || []).each do |c|
        c[:email] = ANON
        c[:phone_number] = ANON
      end
      (registration.registry_info[:charterers] || []).each do |charterer|
        (charterer[:charter_parties] || []).each do |c|
          c[:email] = ANON
          c[:phone_number] = ANON
        end
      end

      registration.save(validation: false)
    end
  end
  # rubocop:enable all

  def submission_documents
    @registered_vessel.submissions.each do |submission|
      submission.documents.each do |document|
        remove_assets(document.assets)
      end
    end
  end

  def vessel_documents
    @registered_vessel.documents.each do |document|
      remove_assets(document.assets)
    end
  end

  def remove_assets(assets)
    assets.each do |asset|
      asset.file.clear
      asset.removed_by = @user
      asset.save
    end
  end

  def notifications_table
    notifications.each do |n|
      n.update_attributes(recipient_email: ANON, recipient_name: ANON)
    end
  end

  def notifications
    Builders::NotificationListBuilder
      .for_registered_vessel(@registered_vessel)
      .select { |n| n.respond_to?(:recipient_email) }
  end
end
