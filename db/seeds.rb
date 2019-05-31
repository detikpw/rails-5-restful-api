# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all

50.times do |index|
    product_name = Faker::Football.player
    Product.create!(
        name: product_name,
        slug: product_name.parameterize,
        description: Faker::Football.team,
        image: Faker::LoremPixel.image("50x60", false, 'sports')
    )
end

p "Created #{Product.count} products"