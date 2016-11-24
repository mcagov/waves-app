class Registration < ApplicationRecord
  belongs_to :actioned_by, class_name: "User", required: false

  def vessel
    symbolized_registry_info[:vessel_info] || {}
  end

  def vessel_name
    vessel[:name] || ""
  end

  def owners
    symbolized_registry_info[:owners] || []
  end

  private

  def symbolized_registry_info
    if registry_info.blank?
      {}
    else
      registry_info.deep_symbolize_keys!
    end
  end
end
