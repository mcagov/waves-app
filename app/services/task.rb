class Task
  def initialize(key)
    @key = key.to_sym
  end

  def ==(other)
    @key == other.to_sym
  end

  def description
    Task.all_task_types.find { |t| t[1] == @key }[0]
  end

  def payment_required?
    ![:change_address, :closure, :enquiry].include?(@key)
  end

  def print_job_templates
    if prints_certificate?
      [:registration_certificate, :cover_letter]
    elsif prints_current_transcript?
      [:current_transcript]
    elsif prints_historic_transcript?
      [:historic_transcript]
    end
  end

  def prints_certificate?
    [
      :new_registration, :change_owner, :change_vessel, :renewal,
      :duplicate_certificate, :re_registration
    ].include?(@key)
  end

  def prints_current_transcript?
    [:closure, :current_transcript].include?(@key)
  end

  def prints_historic_transcript?
    [:historic_transcript].include?(@key)
  end

  def duplicates_certificate?
    [:duplicate_certificate].include?(@key)
  end

  def renews_certificate?
    [:change_owner, :change_vessel, :renewal, :re_registration]
      .include?(@key)
  end

  def builds_registry?
    [
      :change_owner, :change_vessel, :change_address,
      :re_registration, :new_registration, :renewal].include?(@key)
  end

  def builds_registration?
    [
      :change_owner, :change_vessel,
      :re_registration, :new_registration, :renewal].include?(@key)
  end

  def emails_application_approval?
    [
      :new_registration, :renewal, :re_registration,
      :change_owner, :change_vessel, :change_address,
      :closure, :current_transcript, :historic_transcript,
      :duplicate_certificate].include?(@key)
  end

  class << self
    def finance_task_types
      all_task_types.delete_if do |t|
        [:change_address, :closure, :enquiry].include?(t[1])
      end
    end

    def default_task_types
      all_task_types.delete_if { |t| t[1] == :unknown }
    end

    def validation_helper_task_type_list
      default_task_types.map { |t| t[1].to_s }
    end

    # rubocop:disable Metrics/MethodLength
    def all_task_types
      [
        ["New Registration", :new_registration],
        ["Renewal of Registration", :renewal],
        ["Re-Registration", :re_registration],
        ["Change of Ownership", :change_owner],
        ["Change of Vessel details", :change_vessel],
        ["Change of Address", :change_address],
        ["Registration Closure", :closure],
        ["Current Transcript of Registry", :current_transcript],
        ["Historic Transcript of Registry", :historic_transcript],
        ["Duplicate Certificate", :duplicate_certificate],
        ["General Enquiry", :enquiry],
        ["Unknown", :unknown]]
    end
  end
end
