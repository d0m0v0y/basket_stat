require 'faker'

FactoryGirl.define do
  factory :game do
    association :home_team, factory: :team
    association :away_team, factory: :team
    date { DateTime.now }

    factory :started_game do
      started_at { date + 1.minute }
    end
  end
end