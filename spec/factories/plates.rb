FactoryGirl.define do
  factory :plate do
    restaurant
    price FFaker.numerify('##########.##')
    name {FFaker::Lorem.word}
    description {FFaker::Lorem.phrase}
  end
end
