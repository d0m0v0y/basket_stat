require 'factory_girl'
# require Rails.root.join('spec/factories/**')

namespace :db do
  desc "Fill Teams and Players"
  task seed_data: :environment do
    #create teams with players
    12.times do
      team = FactoryGirl.create(:team)
      12.times do
        FactoryGirl.create(:player, team: team)
      end
    end

  end

  task seed_games: :environment do
    # Simulate games
    first_round = RoundRobinTournament.schedule Team.last(4)
    second_round = first_round.map do |day|
     day.map { |pair| pair.reverse }
    end
    (first_round + second_round).each do |day|
      day.each do |pair|
        game = Game.create home_team: pair.first, away_team: pair.last, date: DateTime.current
        sim_service = GameSimulationService.new game
        sim_service.simulate
      end
    end
  end

end
