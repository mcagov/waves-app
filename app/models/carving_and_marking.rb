class CarvingAndMarking < ApplicationRecord
  belongs_to :actioned_by, class_name: "User"
  belongs_to :submission

  delegate :vessel_name, to: :submission
  delegate :part, to: :submission

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
    TEMPLATES.find { |t| t[1] = template.to_sym }[0]
  end

  def vessel
    submission.registered_vessel
  end

  def tonnage_label
    "NET TONNAGE"
  end

  def tonnage_value
    1234.11
  end

  def tonnage_description
    "N.T.101,053.00"
  end
end
