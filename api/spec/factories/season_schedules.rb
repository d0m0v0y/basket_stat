# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :season_schedule do
    day 1
    season nil
    scheduled_at "2016-01-25 14:39:35"
    game nil
    home_team_id 1
    away_team_id 1
  end
end
