FactoryBot.define do
  factory :good_reputation do
    association :user
    association :word
    association :exchanged_word
    star_flag  { [true, false].sample }
  end
end
