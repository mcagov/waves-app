require "rails_helper"

describe Transformer do
  context ".upcase_params" do
    let(:input_params) { { foo: "bar", foo_email: "bob@example.com" } }
    subject { Transformer.upcase_params(input_params) }

    it { expect(subject).to eq(foo: "BAR", foo_email: "bob@example.com") }
  end
end
