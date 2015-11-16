require 'ffaker'

FactoryGirl.define do
  factory :game do
    association :home_team, factory: :team
    association :away_team, factory: :team
    date { DateTime.now - 1.minute }

    factory :started_game do
      started_at { date + 1.minute }
    end
  end
end