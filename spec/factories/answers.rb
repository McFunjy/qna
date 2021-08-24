FactoryBot.define do
  factory :answer do
    body { 'MyAnswer' }
    question { build(:question) }

    trait :invalid do
      body { nil }
    end
  end
end
