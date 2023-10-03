FactoryBot.define do
  factory :project do
    sequence(:name_da) { |n| "Test projekt #{n}" }
    sequence(:name_en) { |n| "Test project #{n}" }
  end
end
