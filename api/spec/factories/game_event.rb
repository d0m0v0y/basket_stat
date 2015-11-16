# require 'spec_helper'

FactoryGirl.define do
  factory :game_event do
    game
    player
    event_time { Time.current }
  end
end
