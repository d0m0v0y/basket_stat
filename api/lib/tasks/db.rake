require 'factory_girl'
# require Rails.root.join('spec/factories/**')

namespace :db do
  desc "Fill Teams and Players"
  task seed_data: :environment do
    #create teams with players
    10.times do
      team = FactoryGirl.create(:team)
      12.times do
        FactoryGirl.create(:player, team: team)
      end
    end
  end

end
