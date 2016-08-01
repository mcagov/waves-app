class Registration < ApplicationRecord
  belongs_to :vessel, required: false

  belongs_to :delivery_address, class_name: "Address", required: false

  def submission
    JSON.parse(changeset, symbolize_names: true)
  end

  def correspondent_info
    submission[:owner_info_1]
  end

  def vessel_info
    submission[:vessel_info]
  end

  def owners
    owner_info_count = submission[:owner_info_count].to_i
    ret = []
    1.upto(owner_info_count) do |i|
      ret << submission["owner_info_#{ i }".to_sym]
    end
    ret
  end
end
