require 'rails_helper'

describe Game do
  context 'invalid model' do
    let(:required_fields) { [:first_name, :last_name, :weight, :height, :number, :team_id] }
    it 'without first_name, last_name, position, weight, height, team_id' do
      player = Player.new
      player.valid?
      expect(player.errors.keys).to contain_exactly(*required_fields)
    end
  end

  context 'valid model' do
    it 'has no errors' do
      player = build :player
      player.valid?
      expect(player.errors).to be_empty
    end
  end

  describe '#points' do
    let(:first_player) { create :player }
    let(:second_player) { create :player }
    let(:game) { create :game}

    before :each do
      # create game_events for second_player to add some "noise" in db
      [:fta, :ftm, :fgm, :fga, :fgm3, :fga3].each do |event_code|
        create :game_event, event_code: event_code, player: second_player, game: game
      end
    end

    [ #events                     points
      [[:ftm, :ftm, :ftm],          3],
      [[:ftm, :fta, :fga, :fgm],    3],
      [[:fgm, :fgm, :fgm3, :fga3],  7]
    ].each do |events, points|
    it "returns #{points} for #{events}" do
      events.each do |event|
        create :game_event, event_code: event, player: first_player, game: game
      end
      expect(first_player.points game.id).to eq points
    end

    end
  end
end