FactoryBot.define do
  factory :reputation do
    association :user
    association :word
    association :exchanged_word
    star_flag { [true, false].sample }
    bad_flag { [true, false].sample }
  end
end
