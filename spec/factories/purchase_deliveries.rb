FactoryBot.define do
  factory :purchase_delivery do
    postal_code       { '123-4567' }
    area_id           { Faker::Number.within(range: 2..48) }
    city              { '館山市' }
    block             { '青山1-1' }
    building          { '建物名' }
    number            { '09011111111' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
