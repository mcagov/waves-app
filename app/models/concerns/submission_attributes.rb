module SubmissionAttributes
  extend ActiveSupport::Concern

  included do
    def owners
      declarations.map(&:owner)
    end

    def vessel
      @vessel ||= Submission::Vessel.new(user_input[:vessel_info])
    end

    def vessel=(vessel_params)
      changeset[:vessel_info] = vessel_params
    end

    def delivery_address
      @delivery_address ||=
        Submission::DeliveryAddress.new(user_input[:delivery_address] || {})
    end

    def delivery_address=(delivery_address_params)
      changeset[:delivery_address] = delivery_address_params
    end

    def correspondent
      declarations.first.owner if declarations
    end

    def correspondent_email
      correspondent.email if correspondent
    end

    def source
      "Online"
    end

    def job_type
      ""
    end

    protected

    def user_input
      changeset.blank? ? {} : changeset.deep_symbolize_keys!
    end
  end
end
