# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :team do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end

end
