class Builders::NameReservationBuilder
  class << self
    def build(submission, name_reservation)
      @submission = submission
      @name_reservation = name_reservation
      @name_reservation.save!

      @submission.update_attribute(:registered_vessel_id, @name_reservation.id)
    end
  end
end
