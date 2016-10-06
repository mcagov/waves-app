module SubmissionHelpers
  extend ActiveSupport::Concern

  included do
    def notification_list
      (correspondences + notifications + declarations.map(&:notification)
      ).compact.sort { |a, b| b.created_at <=> a.created_at }
    end

    def process_application; end

    def editable?
      !completed? && !printing?
    end

    protected

    def unassignable?
      true
    end

    def init_new_submission
      build_ref_no
    end

    def build_ref_no
      self.ref_no = RefNo.generate(ref_no_prefix)
    end

    def ref_no_prefix
      "00"
    end

    def build_declarations
      Builders::DeclarationBuilder.create(
        self,
        user_input[:owners],
        user_input[:declarations]
      )
    end

    def remove_claimant
      update_attribute(:claimant, nil)
    end

    def add_claimant(user)
      update_attribute(:claimant, user)
    end

    def init_processing_dates
      update_attribute(:received_at, Date.today)

      if payment.wp_amount.to_i == 7500
        update_attribute(:target_date, 5.days.from_now)
        update_attribute(:is_urgent, true)
      else
        update_attribute(:target_date, 20.days.from_now)
      end

      update_attribute(:referred_until, nil)
    end
  end
end
