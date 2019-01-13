FactoryBot.define do
  factory :recorded_number do
    number { 1.5 }
    user_id { 1 }
  end
  factory :user do
    telegram_id { "MyString" }
  end
end
