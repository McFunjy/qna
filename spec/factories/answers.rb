FactoryBot.define do
  factory :answer do
    body { 'MyAnswer' }
    association :question, factory: :question
    association :author, factory: :user

    trait :invalid do
      body { nil }
    end
  end
end
