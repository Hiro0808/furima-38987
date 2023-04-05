FactoryBot.define do
  factory :item do
    item_name                 { '鉛筆' }
    description               { 'よくかけます' }
    price                     { '1000' }
    category_id               { '2' }
    condition_id              { '2' }
    shipping_burden_id        { '2' }
    prefecture_id             { '2' }
    date_of_shipment_id       { '2' }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
