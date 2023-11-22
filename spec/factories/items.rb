FactoryBot.define do
  factory :item do
    itemname                    { 'テスト' }
    description                 { Faker::Lorem.sentence }
    category_id                 { '2' }
    condition_id                { '2' }
    shippingfee_id              { '2' }
    shippingorigin_id           { '2' }
    deliverytime_id             { '2' }
    price                       { '1000' }

    association :user # ユーザーとのアソシエーション

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
