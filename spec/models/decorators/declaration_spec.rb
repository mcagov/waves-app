require "rails_helper"

describe Decorators::Declaration, type: :model do
  context "#declaration_required?" do
    let(:declaration) { Declaration.new }

    subject { declaration.declaration_required? }

    it { expect(declaration).to be_truthy }
  end
end
