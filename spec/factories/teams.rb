# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :team do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
  end

end
