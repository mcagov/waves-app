class Registration < ApplicationRecord
  belongs_to :submission, required: false
  belongs_to :actioned_by, class_name: "User", required: false

  def vessel
    symbolized_changeset[:vessel_info] || {}
  end

  def vessel_name
    vessel[:name] || ""
  end

  def owners
    symbolized_changeset[:vessel_info]
  end

  private

  def symbolized_changeset
    if submission_changeset.blank?
      {}
    else
      submission_changeset.deep_symbolize_keys!
    end
  end
end
