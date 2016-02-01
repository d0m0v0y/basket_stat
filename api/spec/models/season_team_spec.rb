require 'rails_helper'

RSpec.describe SeasonTeam, type: :model do
  context 'non unique team per season' do
    it 'returns error on save' do
      season = create :season
      team = create :team
      SeasonTeam.create season: season, team: team
      season_team_dup = SeasonTeam.new season: season, team: team
      expect(season_team_dup.valid?).to be_falsey
    end
  end
end
