require 'rails_helper'

describe Player do
  let(:first_player) { create :player }
  let(:second_player) { create :player }
  let(:game) { create :game}

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

  describe '#percent' do
    before :each do
      # create game_events for second_player to add some "noise" in db
      [:fta, :ftm, :fgm, :fga, :fgm3, :fga3].each do |event_code|
        create :game_event, event_code: event_code, player: second_player, game: game
      end
    end

    [  #attempt        count             made        count          percent
      { attempt: :fta, attempt_count: 10, made: :ftm, made_count: 0, percent: 0.0 },
      { attempt: :fta, attempt_count: 0, made: :ftm, made_count: 4, percent: 100.0 },
      { attempt: :fta, attempt_count: 4, made: :ftm, made_count: 4, percent: 50.0 },
      { attempt: :fga, attempt_count: 4, made: :fgm, made_count: 4, percent: 50.0 },
      { attempt: :fga3, attempt_count: 16, made: :fgm3, made_count: 4, percent: 20.0 }
    ].each do |row|
      it "returns #{row[:percent]} for #{row[:made]}" do
        row[:attempt_count].times do
          create :game_event, event_code: row[:attempt], player: first_player, game: game
        end
        row[:made_count].times do
          create :game_event, event_code: row[:made], player: first_player, game: game
        end
        expect(first_player.percent(game.id, row[:attempt], row[:made])).to eq row[:percent]
      end
    end
  end

  describe '#efficiency' do
    [ #events                            eff
      [[:ast, :ast, :stl, :ftm],          4.4],
      [[:ftm, :fta, :fga, :fgm],          1.2],
      [[:fgm, :fgm, :fgm3, :fga3],        5.5],
      [[:blk, :orb, :fgm, :los, :pf],     2.2],
    ].each do |events, eff|
      it "returns #{eff} for #{events}" do
        events.each do |event|
          create :game_event, event_code: event, player: first_player, game: game
        end
        expect(first_player.efficiency game.id).to eq eff
      end

    end
  end
end
