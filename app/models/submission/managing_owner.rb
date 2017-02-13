class Submission::ManagingOwner < ApplicationRecord
  self.table_name = "declarations"

  def name
    changeset["name"]
  end
end
