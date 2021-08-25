FactoryBot.define do
  sequence :title do |n|
    "MyQuestion#{n}"
  end

  factory :question do
    title
    body { 'MyText' }
    association :author, factory: :user
  end

  trait :invalid do
    title { nil }
  end
end
