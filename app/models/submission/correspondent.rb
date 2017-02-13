class Submission::Correspondent < ApplicationRecord
  self.table_name = "declarations"

  def name
    changeset["name"]
  end

  def email
    changeset["email"]
  end
end
