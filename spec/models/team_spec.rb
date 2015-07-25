require 'rails_helper'

describe Team do
  it 'is invalid without name' do
    team = Team.new
    team.valid?
    expect(team.errors[:name]).to include("can't be blank")
  end

  it 'validates only name' do
    team = Team.new
    team.valid?
    expect(team.errors.keys).to eq [:name]
  end

  it 'store valid team to db' do
    team = Team.new name: 't1', description: 'descr 1'
    expect{ team.save }.to change{ Team.count }.by(1)
  end
end
