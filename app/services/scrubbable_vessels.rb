class ScrubbableVessels
  class << self
    def assign
      filtered_vessels.find_each do |vessel|
        next if vessel.mortgages.registered.any?
        next if vessel.mortgages.where("discharged_at > ?", 7.years.ago).any?
        vessel.update(scrubbable: true)
      end
    end

    private

    def filtered_vessels
      Register::Vessel
        .where(scrubbable: false).where(scrubbed_at: nil)
        .joins(:current_registration)
        .where("registrations.registered_until < ?", 7.years.ago)
        .includes(:mortgages)
    end
  end
end
