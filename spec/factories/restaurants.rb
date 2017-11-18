FactoryGirl.define do
  factory :restaurant do
    name {FFaker::Lorem.word}
    description {FFaker::Lorem.phrase}
  end
end