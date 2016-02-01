require 'rails_helper'

RSpec.describe Season, type: :model do
  pending "#scheduled?"
  describe "adding teams to the season" do
    context "duplicate team" do
      it "don't allow to save duplicate" do
        team = create :team
        season = create :season
        expect { season.teams << [team, team] }.to raise_error
      end
    end
  end
end
