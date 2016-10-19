require "rails_helper"

describe Task do
  context "#description" do
    it do
      expect(Task.description(:new_registration))
        .to eq("New Registration")
    end

    it do
      expect(Task.description(:change_ownership))
        .to eq("Change of Ownership")
    end
  end
end
