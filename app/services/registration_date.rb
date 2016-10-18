class RegistrationDate
  attr_reader :starts_at, :ends_at

  def initialize(starts_at)
    @starts_at = ensure_date(starts_at)
    @ends_at = @starts_at.advance(years: 5)
  end

  private

  def ensure_date(input_date)
    input_date ||= DateTime.now
    input_date.to_datetime
  end
end
