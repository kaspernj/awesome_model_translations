FactoryBot.define do
  factory :gender do
    trait :female do
      name_da { "Kvinde" }
      name_en { "Female" }
    end

    trait :male do
      name_da { "Mand" }
      name_en { "Male" }
    end

    trait :other do
      name_da { "Andet" }
      name_en { "Other" }
    end
  end
end
