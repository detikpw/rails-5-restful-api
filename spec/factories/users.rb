FactoryBot.define do
    factory :user do
      username { Faker::TvShows::GameOfThrones.character.parameterize }
      email {'aladdin@jasmine.com'}
      password {'genie'}
    end
end