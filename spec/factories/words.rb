random = Random.new()
FactoryBot.define do
  factory :word do
    name_num = random.rand(3..30)
    main_category_max_id = 5
    service_category_max_id = 5
    name                  { Faker::Lorem.characters(number: name_num ) }
    main_category_id      { Faker::Number.between(from: 2, to: main_category_max_id) }
    service_category_id   { Faker::Number.between(from: 2, to: service_category_max_id) }
    association :user
  end
end
