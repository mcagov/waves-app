require "rails_helper"

describe Engine do
  context "#total_mcep" do
    let(:engine) do
      Engine.new(mcep_after_derating: 300.34, quantity: 3)
    end

    subject { engine.total_mcep }

    it { expect(subject).to eq(901.02) }
  end
end
