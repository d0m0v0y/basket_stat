require 'ffaker'

FactoryGirl.define do
  factory :player do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    position { Random.rand(1..5) }
    team
    number { Random.rand(3..99) }
    height { Random.rand(180..215) }
    weight { Random.rand(80..130) }
  end
end
