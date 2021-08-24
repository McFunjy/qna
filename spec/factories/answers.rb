FactoryBot.define do
  factory :answer do
    body { 'MyText' }
    question { build(:question) }

    trait :invalid do
      body { nil }
    end
  end
end
