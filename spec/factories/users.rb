FactoryBot.define do
  factory :user do
    email { 'user@mail.ru' }
    password { '123456' }
    password_confirmation { '123456' }
  end
end
