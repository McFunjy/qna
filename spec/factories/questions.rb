FactoryBot.define do
  factory :question do
    title { 'MyQuestion' }
    body { 'MyText' }
  end

  trait :invalid do
    title { nil }
  end
end
