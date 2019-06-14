FactoryBot.define do
    factory :user do
      username { Faker::TvShows::GameOfThrones.character.parameterize }
      email {Faker::Internet.email}
      password {'genie'}
    end
end