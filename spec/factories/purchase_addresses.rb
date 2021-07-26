FactoryBot.define do
  factory :purchase_address do
    postal_code   { '124-4567' }
    delivery_id   { '2' }
    address       { '1-1' }
    municipality  { '渋谷区' }
    building_name { 'ビル' }
    phone_number  { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
