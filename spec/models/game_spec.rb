require 'rails_helper'

describe Game do
  it 'is invalid without date, away_team_id and home_team_id' do
    game = subject
    game.valid?

    expect(game.errors.keys).to include(:date, :home_team_id, :away_team_id)
  end

  it 'store valid game to db' do
    home_team = create(:team)
    away_team = create(:team)
    game = Game.new date: DateTime.now, home_team: home_team, away_team: away_team

    expect{ game.save }.to change{ Game.count }.by(1)
  end

  describe '#start' do
    context 'for not started game' do
      it 'updates .started_at' do
        current_time = DateTime.now
        Timecop.freeze(current_time) do
          game = create(:game)
          new_time = current_time + 1.minute
          Timecop.travel(new_time)
          expect{ game.start }.to change { game.started_at }.from(nil)
          expect(game.started_at).to be_within(1.second).of(new_time)
        end
      end
    end

    context 'for already started game' do
      it 'keeps started_at untouched' do
        game = create(:started_game)
        expect { game.start }.not_to change { game.started_at }
      end
    end
  end

end