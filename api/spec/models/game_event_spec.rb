require 'rails_helper'

describe GameEvent do
  context 'invalid model' do
    let(:required_fields) { [:event_time, :game_id, :player_id, :event_code] }
    it 'without required_fields' do
      game_event = GameEvent.new
      game_event.valid?
      expect(game_event.errors.keys).to contain_exactly(*required_fields)
    end
  end

  context 'valid model' do
    it 'can be saved to db' do
      game_event = build :game_event, event_code: :ftm
      expect { game_event.save }.to change {GameEvent.count}.by(1)
    end
  end

end
