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
end