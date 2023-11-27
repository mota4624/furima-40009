FactoryBot.define do
  factory :order_address do
    postalcode { '123-4567' }
    prefecture { 2 }
    city { '横浜市緑区' }
    housenumber { '1-1' }
    building { '東京ハイツ' }
    phone { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
