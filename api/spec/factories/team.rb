# Read about factories at https://github.com/thoughtbot/factory_girl
require 'ffaker'

FactoryGirl.define do
  factory :team do
    sequence(:name) { |n| "Team ##{n}" }
    description { FFaker::Lorem.sentence }
  end

end
