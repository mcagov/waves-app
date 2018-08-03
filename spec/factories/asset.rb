FactoryBot.define do
  factory :asset do
    file { File.new("#{Rails.root}/spec/support/files/mca_test.pdf") }
  end
end
