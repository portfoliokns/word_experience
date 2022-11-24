FactoryBot.define do
  factory :word_point do
    association :user
    point { Faker::Number.between(from: 0, to: 999_999_999) }
  end
end
