FactoryGirl.define do
  factory :document do
    entity_type :carving_and_marking
    noted_at          { 1.day.ago }
    content           "Some notes"
    issuing_authority "MCA"
    assets            { [build(:asset)] }
  end

  factory :code_certificate, class: "Document" do
    entity_type       :code_certificate
  end
end
