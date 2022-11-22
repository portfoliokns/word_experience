FactoryBot.define do
  factory :good_reputation do
    association :user
    association :word
    association :exchanged_word
    
  end
end
