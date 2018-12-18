class CarvingAndMarking < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  belongs_to :actioned_by, class_name: "User"
  belongs_to :submission

  delegate :vessel_name, to: :submission
  delegate :part, to: :submission

  has_one :print_job, as: :printable, class_name: "PrintJob"
  has_many :notifications, as: :notifiable

  enum delivery_method: [:email, :print]

  attr_accessor :email_subject, :email_body

  TEMPLATES = [
    ["All fishing vessels",
     :all_fishing],
    ["Part 1 and 4 vessels over 500gt",
     :over_500gt],
    ["Part 1 and 4 vessels under 500gt and Part 1 pleasure vessels over 24m",
     :over_24m_under_500gt],
    ["Part 1 pleasure vessels under 24m",
     :under_24m],
  ].freeze

  def template_name
    return "" unless template
    TEMPLATES.find { |t| t[1] == template.to_sym }[0]
  end

  def vessel
    submission.registered_vessel
  end

  def register_length
    vessel.register_length if vessel
  end

  def tonnage_label
    register? ? "REGISTER TONNAGE" : "NET TONNAGE"
  end

  def tonnage_value
    if register?
      Tonnage.new(:register, submission.vessel.register_tonnage).to_s
    else
      Tonnage.new(:net, submission.vessel.net_tonnage).to_s
    end
  end

  def tonnage_description
    return "" if tonnage_value.blank?
    register? ? "R.T.#{tonnage_value}" : "N.T.#{tonnage_value}"
  end

  def emailable?
    delivery_method.to_sym == :email
  end

  private

  def register?
    submission.vessel.net_tonnage.to_i.zero? &&
      (submission.vessel.register_tonnage.to_i > 0)
  end
end
