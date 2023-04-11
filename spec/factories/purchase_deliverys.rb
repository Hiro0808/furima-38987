FactoryBot.define do
  factory :purchase_delivery do
    post_code      { '123-4567' }
    prefecture_id  { '2' }
    city           { '岸和田市' }
    street_address { '土生町1234567' }
    building_name  { 'タッカイビル' }
    phone_number   { '09012345678' }
  end
end
