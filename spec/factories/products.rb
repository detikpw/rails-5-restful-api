FactoryBot.define do
    product_name = Faker::Football.player
    factory :product do
      name { product_name }
      slug { product_name.parameterize }
    end
end