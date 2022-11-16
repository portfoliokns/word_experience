FactoryBot.define do
  factory :exchanged_word do
    association :user
    association :word
  end
end
