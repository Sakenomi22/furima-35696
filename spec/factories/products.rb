FactoryBot.define do
  factory :product do
    name              { Faker::Lorem.sentence }
    description       { Faker::Lorem.sentence }
    category_id       { Faker::Number.within(range: 2..10) }
    status_id         { Faker::Number.within(range: 2..7) }
    judgement_id      { Faker::Number.within(range: 2..3) }
    area_id           { Faker::Number.within(range: 2..48) }
    delivery_day_id   { Faker::Number.within(range: 2..4) }
    price             { Faker::Number.within(range: 300..9999999 )}
    association :user
    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
